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
      value = block.call(element)
      @value_array << value
    end
  end

  def my_each_with_index(&block)
    return puts 'Please provide a block' unless block_given?

    index = 0
    for element in self
      block.call(element, index)
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

  def my_select(&block)
    @select_array = []
    for element in self
      value = block.call(element)
      @select_array << element if value == true
    end
    @select_array
  end

  def my_any?(&block)
    return puts 'Please provide a block' unless block_given?

    my_each(&block)

    case @value_array
    in [*, true, *] then return true
    in [false, *] then return false
    end
  end

  def my_count(&block)
    return self.length unless block_given?

    my_select(&block)
    @select_array.length
  end

  def my_inject(initial_value, &block)
    return puts 'Please provide a block' unless block_given?

    accumulator = initial_value
    for element in self
      accumulator = block.call(accumulator, element)
    end
    accumulator
  end

  def my_map(&block)
    my_each(&block)
    @value_array
  end

  def my_none?(&block)
    my_map(&block)
    my_block = lambda { |element| element == true }
    @value_array.my_count(&my_block) > 0 ? false : true
  end
end

p [1, 1, 2, 3, 5, 8, 13, 21, 34].my_none? { |element| element > 2 }
