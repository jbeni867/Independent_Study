-- QUESTION 1
-- Write a function called concatenate(a1, a2) that takes two arrays and returns a new array with all the elements of a1 followed by all the elements of a2.
function concatenate(a1, a2)
    local result = {}
    local index = 1

    for i = 1, #a1 do
        result[index] = a1[i]
        index = index + 1
    end

    for i = 1, #a2 do
        result[index] = a2[i]
        index = index + 1
    end

    return result
end

-- QUESTION 2
-- Our strict table implementation in ​Reading and Writing​ doesn’t provide a way to delete items from the table. If we try the usual approach, treasure.gold = nil, we get a duplicate key error. Modify strict_write() to allow deleting keys (by setting their values to nil).
function strict_write(table, key, value)
    if value == nil then
        rawset(table, key, nil)
        return
    end
    if rawget(table, key) ~= nil then
        error("Duplicate key error: " .. tostring(key))
    end
    rawset(table, key, value)
end

-- QUESTION 3
-- Change the global metatable you discovered in the Find section earlier so that any time you try to add two arrays using the plus sign (e.g., a1 + a2), Lua concatenates them together using your concatenate() function.
local array_metatable = {
    __add = function(a1, a2)
        return concatenate(a1, a2)
    end
}

-- QUESTION 4
-- Using Lua’s built-in OO syntax, write a class called Queue that implements a first-in, first-out (FIFO) queue as follows:
--     q = Queue.new() returns a new object.
--     q:add(item) adds item past the last one currently in the queue.
--     q:remove() removes and returns the first item in the queue, or nil if the queue is empty.

Queue = {}
Queue.__index = Queue

function Queue.new()
    local obj = {
        data = {}
    }
    setmetatable(obj, Queue)
    return obj
end

function Queue:add(item)
    table.insert(self.data, item)
end

function Queue:remove()
    if #self.data == 0 then
        return nil
    end
    return table.remove(self.data, 1)
end