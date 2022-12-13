# frozen_string_literal: true
# require 'pry-byebug'

# Module of my own custom enumerables
module Enumerable
  # Your code goes here
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each(&block)
    return self unless block_given?

    @value_array = []
    for element in self
      value = block.call element
      @value_array << value
    end
  end

  def my_each_with_index(&block)
    index = 0
    for element in self
      yield(element, index)
      index += 1
    end
  end

  def my_all?(&block)
    return puts 'Please provide a block' unless block_given?

    my_each(&block)

    case @value_array
    in [*, false, *] then return false
    in [true, *] then return true
    end
  end

end
