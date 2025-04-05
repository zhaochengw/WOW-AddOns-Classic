# AceGUI-3.0-Search-EditBox

An edit box widget for AceGUI-3.0 that adds a prediction list of results while the user is typing, based on AceGUI-3.0-Spell-Edit-Box and AceGUI-3.0-Completing-EditBox, but with all the spells code management removed, so this is a generic widget, does not display anything by itself, the displayed results must be provided by external code.

# Documentation

Example of predictor table/object with all supported callbacks. Only "GetValues" function is mandatory, the rest of callbacks are optional:

```
local Predictor = {}
function Predictor:Initialize()
end
function Predictor:GetValues(text, values, max )
end
function Predictor:GetValue(text, key )
end
function Predictor:GetHyperlink( key )
end
LibStub("AceGUI-3.0-Search-EditBox"):Register( "MyAddonPredictor", Predictor )
```

## Initialize()

This method is executed only once, the first time an EditBox widget linked to the predictor receives the focus. Can be used for initialization tasks. The current implementation is bugged, this function is executed several times if more than one widget is created. Remove this method from the predictor table after the initialization to avoid the bug (simply add a: self.Initialize = nil as last line in the initialize method).

## GetValues(text, values, max )

Request the data to be displayed in results dropdown frame:

* __text__: Text typed by the user in the edit box
* __values__: an empty table to save the results, this is optional, a different table can be used (you must return the custom table). The table items format is: [key] = text, where "text" must by a string and "key" can be any type: string, integer, number, table, function, etc).
* __max__: maximum number of results displayed (always 15 in current implementation), less results can be provided.
* __returns__: nil or a custom results table.

## GetValue(text, key )

Validation function. Executed when the user pushes the "Enter" key, "Okay" button or clicks on a result value. The text and key params can be used to decide if the result is valid or to change the returned value.

Params:

* __text__: The text typed in the edit box
* __key__: The key value of the item selected in the results dropdown frame (one of the keys previously provided by GetValues). This value can be nil, for example if the user clicked on the "Okay" button without selecting any item in the results dropdown frame.

Return values:

* return nil to discard the value and cancel the "OnEnterPress" event
* return key, text
    * key = value that will be passed to the "set" handler of the option table (and used in the "OnEnterPressed" widget event)
    * text = text to assign to the widget EditBox (this text is optional).

## GetHyperlink( key )

Return an hyperlink "text", displayed when the user moves the mouse pointer over a result.
