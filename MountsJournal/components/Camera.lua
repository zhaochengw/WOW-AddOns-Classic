local mounts, journal, math = MountsJournal, MountsJournalFrame, math


journal:on("SET_ACTIVE_CAMERA", function(self, activeCamera)
	local ORBIT_CAMERA_MOUSE_PAN_HORIZONTAL, ORBIT_CAMERA_MOUSE_PAN_VERTICAL = ORBIT_CAMERA_MOUSE_PAN_HORIZONTAL, ORBIT_CAMERA_MOUSE_PAN_VERTICAL
	local GetScaledCursorDelta, GetScaledCursorPosition = GetScaledCursorDelta, GetScaledCursorPosition
	local DeltaLerp, Vector3D_CalculateNormalFromYawPitch, Vector3D_ScaleBy, Vector3D_Add = DeltaLerp, Vector3D_CalculateNormalFromYawPitch, Vector3D_ScaleBy, Vector3D_Add
	local pi2 = math.pi * 2

	function activeCamera:setMaxOffsets()
		local w, h = self:GetOwningScene():GetSize()
		local hw, hh = w / 2, h / 2
		local extra = 50
		self.xMaxOffset = hw + extra
		self.yMaxOffset = hh + extra
		self.xMaxCursor = self.xMaxOffset / self:GetDeltaModifierForCameraMode(self.buttonModes.rightX) - hw
		self.yMaxCursor = self.yMaxOffset / self:GetDeltaModifierForCameraMode(self.buttonModes.rightY) - hh
	end

	function activeCamera:SaveInitialTransform()
		local initialLightYaw, initialLightPitch = Vector3D_CalculateYawPitchFromNormal(Vector3D_Normalize(self:GetOwningScene():GetLightDirection()))
		self.lightDeltaYaw = initialLightYaw - self:GetYaw()
		self.lightDeltaPitch = initialLightPitch - self:GetPitch()
	end

	local function TryCreateZoomSpline(x, y, z, existingSpline)
		if x and y and z and (x ~= 0 or y ~= 0 or z ~= 0) then
			local spline = existingSpline or CreateCatmullRomSpline(3)
			spline:ClearPoints()
			spline:AddPoint(0, 0, 0)
			spline:AddPoint(x, y, z)

			return spline
		end
	end

	function activeCamera:ApplyFromModelSceneCameraInfo(modelSceneCameraInfo, transitionType, modificationType)

		local transitionalCameraInfo = self:CalculateTransitionalValues(self.modelSceneCameraInfo, modelSceneCameraInfo, modificationType)
		self.modelSceneCameraInfo = modelSceneCameraInfo

		self:SetTarget(transitionalCameraInfo.target:GetXYZ())
		self:SetTargetSpline(TryCreateZoomSpline(transitionalCameraInfo.zoomedTargetOffset:GetXYZ()), self:GetTargetSpline())
		self:SetOrientationSpline(TryCreateZoomSpline(transitionalCameraInfo.zoomedYawOffset, transitionalCameraInfo.zoomedPitchOffset, transitionalCameraInfo.zoomedRollOffset), self:GetOrientationSpline())

		self:SetMinZoomDistance(transitionalCameraInfo.minZoomDistance)
		self:SetMaxZoomDistance(transitionalCameraInfo.maxZoomDistance)

		self:SetZoomDistance(transitionalCameraInfo.zoomDistance)

		self:SetYaw(transitionalCameraInfo.yaw)
		self:SetPitch(transitionalCameraInfo.pitch)
		self:SetRoll(transitionalCameraInfo.roll)

		if self.xOffset == nil then
			self.xOffset = 0
			self.yOffset = 0
			self.panningXOffset = 0
			self.panningYOffset = self.yOffset
			self:setMaxOffsets()
			self:SaveInitialTransform()
		end

		if transitionType == CAMERA_TRANSITION_TYPE_IMMEDIATE then
			self:SnapAllInterpolatedValues()
		end
		self:UpdateCameraOrientationAndPosition()
	end

	function activeCamera:setAcceleration(deltaX, deltaY, elapsed)
		self.accX = deltaX / elapsed * mounts.cameraConfig.xInitialAcceleration
		local xMinInit = 400 * mounts.cameraConfig.xInitialAcceleration
		if self.accX > -xMinInit and self.accX < xMinInit then self.accX = nil end

		self.accY = deltaY / elapsed * mounts.cameraConfig.yInitialAcceleration
		local yMinInit = 400 * mounts.cameraConfig.yInitialAcceleration
		if self.accY > -yMinInit and self.accY < yMinInit then self.accY = nil end
	end

	local function getDeltaAcceleration(curAcc, elapsed, kAcc, kSpeed)
		local delta = curAcc * elapsed
		delta = delta + elapsed * delta * kAcc
		local newAcc = delta / elapsed
		local minSpeed = 50 * kSpeed

		if curAcc >= 0 and newAcc < 0 or curAcc < 0 and newAcc >= 0 then
			newAcc = 0
		end

		if math.abs(newAcc) < minSpeed then
			newAcc = minSpeed * (curAcc < 0 and -1 or 1)
			return newAcc * elapsed, newAcc
		end

		if newAcc < 5 and newAcc > -5 then return end
		return delta, newAcc
	end

	function activeCamera:updateAcceleration(elapsed)
		if not mounts.cameraConfig.xAccelerationEnabled then self.accX = nil end
		if not mounts.cameraConfig.yAccelerationEnabled then self.accY = nil end

		if self.accX then
			local deltaX, accX = getDeltaAcceleration(self.accX, elapsed, mounts.cameraConfig.xAcceleration, mounts.cameraConfig.xMinSpeed)
			self.accX = accX
			if deltaX then
				self:HandleMouseMovement(self.buttonModes.leftX, deltaX * self:GetDeltaModifierForCameraMode(self.buttonModes.leftX), not self.buttonModes.leftXinterpolate)
			end
		end

		if self.accY then
			local deltaY, accY = getDeltaAcceleration(self.accY, elapsed, mounts.cameraConfig.yAcceleration, mounts.cameraConfig.yMinSpeed)
			self.accY = accY
			if deltaY then
				self:HandleMouseMovement(self.buttonModes.leftY, deltaY * self:GetDeltaModifierForCameraMode(self.buttonModes.leftY), not self.buttonModes.leftYinterpolate)
			end
		end
	end

	local HandleMouseMovement = activeCamera.HandleMouseMovement
	function activeCamera:HandleMouseMovement(mode, delta, snapToValue)
		if mode == ORBIT_CAMERA_MOUSE_PAN_HORIZONTAL then
			self.xOffset = self.xOffset + delta

			if self.xOffset > self.xMaxOffset then self.xOffset = self.xMaxOffset
			elseif self.xOffset < -self.xMaxOffset then self.xOffset = -self.xMaxOffset end

			if snapToValue then
				self.panningXOffset = nil
			end
		elseif mode == ORBIT_CAMERA_MOUSE_PAN_VERTICAL then
			self.yOffset = self.yOffset + delta

			if self.yOffset > self.yMaxOffset then self.yOffset = self.yMaxOffset
			elseif self.yOffset < -self.yMaxOffset then self.yOffset = -self.yMaxOffset end

			if snapToValue then
				self.panningYOffset = nil
			end
		else
			HandleMouseMovement(self, mode, delta, snapToValue)
		end
	end

	function activeCamera:OnUpdate(elapsed)
		if self:IsLeftMouseButtonDown() then
			local deltaX, deltaY = GetScaledCursorDelta()
			self:setAcceleration(deltaX, deltaY, elapsed)
			self:HandleMouseMovement(self.buttonModes.leftX, deltaX * self:GetDeltaModifierForCameraMode(self.buttonModes.leftX), not self.buttonModes.leftXinterpolate)
			self:HandleMouseMovement(self.buttonModes.leftY, deltaY * self:GetDeltaModifierForCameraMode(self.buttonModes.leftY), not self.buttonModes.leftYinterpolate)
		elseif self.accX or self.accY then
			self:updateAcceleration(elapsed)
		end

		if self:IsRightMouseButtonDown() then
			local deltaX, deltaY = GetScaledCursorDelta()
			local x, y = GetScaledCursorPosition()
			local modelScene = self:GetOwningScene()
			if deltaX > 0 and x > modelScene:GetLeft() - self.xMaxCursor
			or deltaX < 0 and x < modelScene:GetRight() + self.xMaxCursor then
				self:HandleMouseMovement(self.buttonModes.rightX, deltaX * self:GetDeltaModifierForCameraMode(self.buttonModes.rightX), not self.buttonModes.rightXinterpolate)
			end
			if deltaY > 0 and y > modelScene:GetBottom() - self.yMaxCursor
			or deltaY < 0 and y < modelScene:GetTop() + self.yMaxCursor then
				self:HandleMouseMovement(self.buttonModes.rightY, -deltaY * self:GetDeltaModifierForCameraMode(self.buttonModes.rightY), not self.buttonModes.rightYinterpolate)
			end
		end

		self:UpdateInterpolationTargets(elapsed)
		self:SynchronizeCamera()
	end

	local function InterpolateDimension(lastValue, targetValue, amount, elapsed)
		return lastValue and DeltaLerp(lastValue, targetValue, amount, elapsed) or targetValue
	end

	hooksecurefunc(activeCamera, "UpdateInterpolationTargets", function(self, elapsed)
		self.panningXOffset = InterpolateDimension(self.panningXOffset, self.xOffset, .15, elapsed)
		self.panningYOffset = InterpolateDimension(self.panningYOffset, self.yOffset, .15, elapsed)
	end)

	function activeCamera:UpdateCameraOrientationAndPosition()
		local yaw, pitch, roll = self:GetInterpolatedOrientation()
		local modelScene = self:GetOwningScene()
		modelScene:SetCameraOrientationByYawPitchRoll(yaw, pitch, roll)

		local axisAngleX, axisAngleY, axisAngleZ = Vector3D_CalculateNormalFromYawPitch(yaw, pitch)
		local targetX, targetY, targetZ = self:GetInterpolatedTarget()
		local zoomDistance = self:GetInterpolatedZoomDistance()

		-- Panning start --
		-- We want the model to move 1-to-1 with the mouse.
		-- Panning formula: dx / hypotenuse * zoomDistance
		local width, height = modelScene:GetSize()
		local zoomFactor = zoomDistance / math.sqrt(width * width + height * height)

		local rightX, rightY, rightZ = Vector3D_ScaleBy(self.panningXOffset * zoomFactor, self:GetRightVector())
		local upX, upY, upZ = Vector3D_ScaleBy(self.panningYOffset * zoomFactor, self:GetUpVector())
		targetX, targetY, targetZ = Vector3D_Add(targetX, targetY, targetZ, rightX, rightY, rightZ)
		targetX, targetY, targetZ = Vector3D_Add(targetX, targetY, targetZ, upX, upY, upZ)
		-- Panning end --

		modelScene:SetCameraPosition(self:CalculatePositionByDistanceFromTarget(targetX, targetY, targetZ, zoomDistance, axisAngleX, axisAngleY, axisAngleZ))
	end

	function activeCamera:UpdateLight()
		if self:ShouldAlignLightToOrbitDelta() then
			local lightYaw = self.lightDeltaYaw + self.interpolatedYaw
			local lightPitch = self.lightDeltaPitch + self.interpolatedPitch
			self:GetOwningScene():SetLightDirection(Vector3D_CalculateNormalFromYawPitch(lightYaw, lightPitch))
		end
	end

	activeCamera:SetLeftMouseButtonYMode(ORBIT_CAMERA_MOUSE_MODE_PITCH_ROTATION, true)
	activeCamera:SetRightMouseButtonXMode(ORBIT_CAMERA_MOUSE_PAN_HORIZONTAL, true)
	activeCamera:SetRightMouseButtonYMode(ORBIT_CAMERA_MOUSE_PAN_VERTICAL, true)

	activeCamera.deltaModifierForCameraMode = setmetatable({
		[ORBIT_CAMERA_MOUSE_MODE_YAW_ROTATION] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_MODE_YAW_ROTATION),
		[ORBIT_CAMERA_MOUSE_MODE_PITCH_ROTATION] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_MODE_PITCH_ROTATION),
		[ORBIT_CAMERA_MOUSE_MODE_ROLL_ROTATION] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_MODE_ROLL_ROTATION),
		[ORBIT_CAMERA_MOUSE_MODE_ZOOM] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_MODE_ZOOM),
		[ORBIT_CAMERA_MOUSE_MODE_TARGET_HORIZONTAL] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_MODE_TARGET_HORIZONTAL),
		[ORBIT_CAMERA_MOUSE_MODE_TARGET_VERTICAL] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_MODE_TARGET_VERTICAL),
		[ORBIT_CAMERA_MOUSE_PAN_HORIZONTAL] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_PAN_HORIZONTAL),
		[ORBIT_CAMERA_MOUSE_PAN_VERTICAL] = activeCamera:GetDeltaModifierForCameraMode(ORBIT_CAMERA_MOUSE_PAN_VERTICAL),
	}, {__index = function() return 0 end})

	function activeCamera:GetDeltaModifierForCameraMode(mode)
		return self.deltaModifierForCameraMode[mode]
	end

	function activeCamera:SetYaw(yaw)
		self.yaw = yaw % pi2
	end

	function activeCamera:SetPitch(pitch)
		self.pitch = pitch % pi2
	end

	function activeCamera:SetRoll(roll)
		self.roll = roll % pi2
	end

	local function normalizeRad(angle, defAngle)
		angle = math.fmod((angle or 0) - defAngle, pi2)
		if angle > math.pi then angle = angle - pi2
		elseif angle < -math.pi then angle = angle + pi2 end
		return angle + defAngle
	end

	function activeCamera:resetPosition()
		self.accX = nil
		self.accY = nil
		self.interpolatedYaw = normalizeRad(self.interpolatedYaw, self.modelSceneCameraInfo.yaw)
		self.interpolatedPitch = normalizeRad(self.interpolatedPitch, self.modelSceneCameraInfo.pitch)
		self.interpolatedRoll = normalizeRad(self.interpolatedRoll, self.modelSceneCameraInfo.roll)
		self:SetYaw(self.modelSceneCameraInfo.yaw)
		self:SetPitch(self.modelSceneCameraInfo.pitch)
		self:SetRoll(self.modelSceneCameraInfo.roll)
		self:SetZoomDistance(self.modelSceneCameraInfo.zoomDistance)
		self.xOffset = 0
		self.yOffset = 0
	end
end)