module UrlShortener
  class IncrementBase62

    NoMoreDigits = Class.new(StandardError)
    DIGITS = "123456789abcdefghijklmnopqrstuvwzxyABCDEFGHIJKLMNOPQRSTUVWZXY"

    def increment(number)
      return "1" if number == ""

      last_char = number[-1]

      incremented_by_one = next_digit(last_char)
      decimals_except_the_last(number) + incremented_by_one
    rescue NoMoreDigits
      increment(decimals_except_the_last(number)) + "0"
    end

    def decimals_except_the_last(number)
      number[0..-2]
    end

    def next_digit(digit)
      raise NoMoreDigits if digit == "Y"

      return "1" if digit == "0"

      DIGITS[DIGITS.index(digit) + 1]
    end
  end
end