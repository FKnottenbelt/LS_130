=begin

Point Mutations

Write a program that can calculate the Hamming difference between two DNA
strands.

A mutation is simply a mistake that occurs during the creation or copying
of a nucleic acid, in particular DNA. Because nucleic acids are vital to
cellular functions, mutations tend to cause a ripple effect throughout the
cell. Although mutations are technically mistakes, a very rare mutation may
equip the cell with a beneficial attribute. In fact, the macro effects of
evolution are attributable by the accumulated result of beneficial
microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point
mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands
taken from different genomes with a common ancestor, we get a measure of
the minimum number of point mutations that could have occurred on the
evolutionary path between the two strands.

This is called the 'Hamming distance'

GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^

he Hamming distance between these two DNA strands is 7.

The Hamming distance is only defined for sequences of equal length. If
you have two sequences of unequal length, you should compute the Hamming
distance over the shorter length.
=end

=begin
p: for as long as 2 strings have an equal length count the number
of occurences where they do not have the same character at the same index

a: find length to match
loop while smaller then length, compare and count
return count
=end

class DNA
  attr_reader :strand

  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(distance)
    length = [strand.size, distance.size].min
    counter = 0
    hamming_distance = 0
    loop do
      break if counter == length
      hamming_distance += 1 if strand[counter] != distance[counter]
      counter += 1
    end
    hamming_distance
  end
end

# top solutions
class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(strand_2)
    strand_1 = @strand[0, strand_2.length]

    strand_1.chars.zip(strand_2.chars).count { |pair| pair.first != pair.last }
  end
end

class DNA
  def initialize(strand1)
    @strand1 = strand1
  end

  def hamming_distance(strand2)
    distance = 0
    min, max = [@strand1, strand2].sort_by(&:size)
    min.each_char.with_index do |char, index|
      distance += 1 unless char == max[index]
    end
    distance
  end
end

class DNA # :nodoc:
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other)
    length = [@strand.size, other.size].min - 1

    (0..length).reduce(0) do |distance, idx|
      @strand[idx] == other[idx] ? distance : distance + 1
    end
  end
end
