package penguin;

class PenguinStateMachine
{
	public var statesDictionary:Map<String, PenguinState> = new Map<String, PenguinState>();
	public var currentState:PenguinState = null;

	public function new(initialState:String, instance:PenguinState)
	{

	}

	public function update(elapsed:Float):Void
	{
		//if (currentState != null)
			//currentState.update(elapsed);
	}

	public function addStateToList(stateIdentifier:String, stateInstance:PenguinState):Void {
		if (!statesDictionary.exists(stateIdentifier))
			statesDictionary.set(stateIdentifier, stateInstance);
	}
	
	public function setState(state:String):Void
	{
		if(statesDictionary.exists(state))
			currentState = statesDictionary.get(state);
	}
}