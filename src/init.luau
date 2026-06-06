--!strict
--[=[
	A BaseObject basically just adds the :Destroy() interface, and a _maid, along with an optional object it references.
	@class BaseObject
]=]

const Maid = require('./roblox_packages/Maid')

const BaseObject = {}
BaseObject.ClassName = 'BaseObject'
BaseObject.__index = BaseObject

export type BaseObject<T> = typeof(setmetatable(
	{} :: {
		_obj: T?,
		_maid: Maid.Maid,
	},
	{} :: typeof({ __index = BaseObject })
))

--[=[
	Constructs a new BaseObject

	@param obj? Instance
	@return BaseObject
]=]
@checked
function BaseObject.new<T>(obj: T?): BaseObject<T>
	return setmetatable({
		_maid = Maid.new(),
		_obj = obj :: T?,
	}, BaseObject)
end

--[=[
	Cleans up the BaseObject and sets the metatable to nil
]=]
@checked
function BaseObject.Destroy<T>(self: BaseObject<T>): ()
	self._maid:DoCleaning()
	setmetatable(self :: any, nil)
end

return BaseObject
