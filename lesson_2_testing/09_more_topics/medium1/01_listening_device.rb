=begin

Listening Device

Below we have a listening device. It lets us record something that is
said and store it for later use. In general, this is how the device
should be used:

Listen for something, and if anything is said, record it for later use.
If nothing is said, then do not record anything.

class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end
end

Anything that is said is retrieved by this listening device via a block.
If nothing is said, then no block will be passed in. The listening device
can also output what was recently recorded using a Device#play method.

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"

Finish the above program so that the specifications listed above are met.
=end


class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    what_is_said = nil
    if block_given?
      what_is_said = yield
    end
    record(what_is_said) if what_is_said
  end

  def play
    @recordings.each { |tekst| puts tekst }
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.listen { "Goodbye World!" }
listener.play # Outputs "Hello World!"

# ls solution
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    return unless block_given?
    recording = yield
    record(recording)
  end

  def play
    puts @recordings.last
  end
end

=begin
Discussion

We can see what needs to be implemented if we compare the code from the last code block of the description with the code given for our Device class.

It seems we are missing a Device#listen method and a Device#play method. In our solution, we implement the Device#listen method by yielding to a block, and then we record what was in that block if necessary.

Notice that we include return unless block_given? to handle the situation where a block is not provided to Device#listen. Without this line, we will get a LocalJumpError. Using block_given? to check for a block is needed when blocks are optional.

We're using a guard clause in our listen method to handle the no-block case, but we could also write code that is functionally identical like so:

def listen
  recording = yield if block_given?
  record(recording) if recording
end

For our play method, we make sure to output what was last recorded using puts @recordings.last.

If nothing has been recorded, then we output nothing. And if there was something recorded, then that string will be the output from this Device#play method.
=end