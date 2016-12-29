class Money < Numeric
  include Comparable

  attr_accessor :cents

  def initialize(value = nil)
    self.cents = self.class.to_cents(value)
  end

  delegate :to_i, :nil?, :blank?, :present?, :zero?, :presence, to: :cents
  delegate :to_f, to: :dollars
  delegate :to_json, to: :dollars

  def dollars
    (cents || 0) / 100.0
  end

  def to_s
    ActionController::Base.helpers.number_to_currency(dollars || 0)
  end

  def inspect
    "#<Money cents: #{cents.inspect}>"
  end

  # -------------------------------
  #  Comparison methods
  # -------------------------------

  def coerce(other)
    if self === other
      [other.to_i, to_i]
    else
      [other.to_f, to_f]
    end
  end

  def ==(other)
    cents == Money.to_cents(other)
  end
  alias eql? ==

  # -------------------------------
  #  Arithmetic operators
  # -------------------------------

  def +(other)
    Money.new(cents + Money.to_cents(other))
  end

  def -(other)
    Money.new(cents - Money.to_cents(other))
  end

  def *(other)
    Money.new((cents * other).to_i)
  end

  def /(other)
    Money.new((cents / other).to_i)
  end

  def -@
    self * -1
  end

  # -------------------------------
  #  Logic operators
  # -------------------------------

  def <=>(other)
    cents <=> Money.to_cents(other)
  end

  def <(other)
    (self <=> other) == -1
  end

  def >(other)
    (self <=> other) == 1
  end

  def <=(other)
    !(self > other)
  end

  def >=(other)
    !(self < other)
  end

  class << self
    def to_cents(value)
      return value.cents if value.is_a?(Money)
      return parse_string(value) if value.is_a?(String)
      return value.to_i if value.is_a?(Fixnum) || value.is_a?(Integer)
      return (value * 100).round if value.is_a?(Float)
    end

    def parse_string(value)
      return unless value =~ /\d+\.\d+/ || value =~ /\d+/
      (value.delete('$,').to_f * 100).round
    end
  end
end
