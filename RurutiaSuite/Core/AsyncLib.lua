-- ========================================
-- Core/AsyncLib.lua
-- 异步处理库 (协程管理器)
-- ========================================
-- 职责：
-- 1. 管理协程任务队列
-- 2. 提供基于时间预算的帧更新调度
-- 3. 提供通用的列表处理框架 (ProcessList)
-- ========================================

local addonName, ns = ...
local RS = LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite", true)
if not RS then return end

-- 创建 AsyncLib 模块
local AsyncLib = RS:NewModule("AsyncLib", "AceEvent-3.0", "AceTimer-3.0")
RS.AsyncLib = AsyncLib -- 方便外部访问

-- 状态定义
local STATUS_PENDING = "PENDING"
local STATUS_RUNNING = "RUNNING"
local STATUS_SUSPENDED = "SUSPENDED"
local STATUS_COMPLETED = "COMPLETED"
local STATUS_ERROR = "ERROR"

-- 默认每帧最大执行时间 (毫秒)
local DEFAULT_TIME_BUDGET = 12 -- 12ms (60fps = 16.6ms, 留给渲染和其他逻辑 4ms)

function AsyncLib:OnInitialize()
    self.tasks = {}       -- 活动任务列表
    self.frame = CreateFrame("Frame") -- 更新帧
    self.frame:Hide()
    self.frame:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)
end

function AsyncLib:OnEnable()
    -- 启用时逻辑
end

-- ========================================
-- 核心 API
-- ========================================

-- 1. 创建并启动任务
-- @param func: 协程函数 (包含 coroutine.yield())
-- @param onComplete: 完成回调 (可选)
-- @param onError: 错误回调 (可选)
-- @param config: 配置表 { name="TaskName", budget=10, priority=1 }
function AsyncLib:Run(func, onComplete, onError, config)
    config = config or {}
    
    local task = {
        co = coroutine.create(func),
        status = STATUS_PENDING,
        name = config.name or "AnonymousTask",
        budget = config.budget or DEFAULT_TIME_BUDGET,
        priority = config.priority or 0,
        onComplete = onComplete,
        onError = onError,
        startTime = GetTime(),
        progress = 0
    }
    
    table.insert(self.tasks, task)
    self.frame:Show()
    
    return task
end

-- 2. 处理列表数据 (通用模板)
-- @param list: 数据列表
-- @param processor: 处理单个项目的函数 (item, index)。如果 processor 返回 false，则终止处理。
-- @param batchSize: 每次 yield 前处理的数量 (默认 1，建议设为 1 交由 AsyncLib 调度)
-- @param onComplete: 完成回调
-- @param onProgress: 进度回调 (可选，接收 0-1 的进度值)
function AsyncLib:ProcessList(list, processor, batchSize, onComplete, onProgress)
    batchSize = batchSize or 1
    
    local func = function()
        local total = #list
        for i, item in ipairs(list) do
            local result = processor(item, i)
            
            -- 如果 processor 返回 false，提前终止
            if result == false then break end
            
            -- 每处理 batchSize 个项目，yield 一次
            if i % batchSize == 0 then
                local progress = i / total
                coroutine.yield(progress) 
                if onProgress then onProgress(progress) end
            end
        end
        return true -- 完成
    end
    
    return self:Run(func, onComplete, nil, { name = "ProcessList" })
end

-- ========================================
-- 内部逻辑
-- ========================================

function AsyncLib:OnUpdate(elapsed)
    if #self.tasks == 0 then
        self.frame:Hide()
        return
    end
    
    local frameStart = debugprofilestop()
    local budget = DEFAULT_TIME_BUDGET
    
    -- 只要有时间且有任务，就一直循环执行
    while (debugprofilestop() - frameStart) < budget and #self.tasks > 0 do
        local worked = false
        
        -- 倒序遍历，方便移除完成的任务
        for i = #self.tasks, 1, -1 do
            -- 再次检查时间预算 (粒度控制)
            if (debugprofilestop() - frameStart) >= budget then break end
            
            local task = self.tasks[i]
            
            if task.status == STATUS_PENDING or task.status == STATUS_RUNNING then
                task.status = STATUS_RUNNING
                
                -- 恢复协程
                -- 注意：这里 resume 后，协程会运行直到遇到 yield 或结束
                local success, result = coroutine.resume(task.co)
                worked = true
                
                if not success then
                    -- 发生错误
                    task.status = STATUS_ERROR
                    local errMsg = result
                    -- 使用 geterrorhandler 报告错误，但不中断主线程
                    geterrorhandler()(errMsg)
                    if task.onError then task.onError(errMsg) end
                    table.remove(self.tasks, i)
                elseif coroutine.status(task.co) == "dead" then
                    -- 任务完成
                    task.status = STATUS_COMPLETED
                    if task.onComplete then task.onComplete(result) end
                    table.remove(self.tasks, i)
                else
                    -- 任务挂起 (Yielded)
                    -- result 是 yield 返回的值 (通常是进度)
                    if type(result) == "number" then
                        task.progress = result
                    end
                    -- 任务状态保持 RUNNING (或可以设为 SUSPENDED)，等待下一轮 resume
                end
            end
        end
        
        -- 如果遍历了一圈没有任何任务被执行 (所有任务都挂起且无法 resume? 不太可能，除非逻辑错误)，跳出防止死循环
        if not worked then break end
    end
    
    -- 如果所有任务都完成了
    if #self.tasks == 0 then
        self.frame:Hide()
    end
end
