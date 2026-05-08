UI Object
    -> Type: UI Type (Button, TextLabel) [String]
    -> Function1: UI Action (Open, Close, EventFireServer) [String]
    -> Open1: UI to open [String]
    -> Close1: UI to close [String]
    -> UI: clone of GUI instance
    -> Parent: String name for the target parent
    -> OpenPrio: Number
    -> ClosePrio: Number

UI Open
    Receive a folder containing all UI for a single frame.
    Create UI Object for those that has tag "UI_Obj"
    Group different Priority numbers
    Loop through highest priority UIs and initialize them.
    Loop through second highest, initalize, and so on