class Banner
  def initialize(message)
      @message = message
      @spaces = ""
      @dashes = ""
      message.length.times do
          @spaces = @spaces + " "
          @dashes = @dashes + "-"
      end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
      "+-"+"#{@dashes}"+"-+"
  end

  def empty_line
      "| #{@spaces} |"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
banner = Banner.new('')
puts banner
