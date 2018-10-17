=begin
Lets write a program that will translate RNA sequences into proteins. RNA can
be broken into three nucleotide sequences called codons, and then translated
to a polypeptide like so:

RNA: "AUGUUUUCU" => translates to

Codons: "AUG", "UUU", "UCU"
=> which become a polypeptide with the following sequence =>

Protein: "Methionine", "Phenylalanine", "Serine"

There are 64 codons which in turn correspond to 20 amino acids; however, all
of the codon sequences and resulting amino acids are not important in this
exercise.

There are also four terminating codons (also known as 'STOP' codons); if any
of these codons are encountered (by the ribosome), all translation ends
and the protein is terminated. All subsequent codons after are ignored,
like this:

RNA: "AUGUUUUCUUAAAUG" =>

Codons: "AUG", "UUU", "UCU", "UAA", "AUG" =>

Protein: "Methionine", "Phenylalanine", "Serine"

Note the stop codon terminates the translation and the final methionine
is not translated into the protein sequence.--

Below are the codons and resulting Amino Acids needed for the exercise.
Codon 	            Protein
AUG 	              Methionine
UUU, UUC 	          Phenylalanine
UUA, UUG 	          Leucine
UCU, UCC, UCA, UCG 	Serine
UAU, UAC 	          Tyrosine
UGU, UGC 	          Cysteine
UGG 	              Tryptophan
UAA, UAG, UGA     	STOP
=end

=begin
p: translate rna strands into codons
   translate codons into proteins

r: rna to codons => slices of 3 chars
   codons to protein => see table
   if invalid strand raise InvalidCodonError

d: to hold strand-into-codons : array
   codon -> protein: hash

a: rna strands into codons:
   slice strand into 3 character codons (strand_to_colon)
   for each codons,
     raise InvalidColonError if invalid colon
     look up the protein  (of_codon)
     stop once you encounter a STOP
     add protein to array if not a STOP
   output array

   codon into protein (of_codon)
   select the entries that include our codon
   take the first key(protein) in the selection

=end

class InvalidCodonError < StandardError; end

class Translation
  AMINO_ACIDS = { Methionine: 'AUG',
                  Phenylalanine: ['UUU', 'UUC'],
                  Leucine: ['UUA', 'UUG'],
                  Serine: ['UCU', 'UCC', 'UCA', 'UCG'],
                  Tyrosine: ['UAU', 'UAC'],
                  Cysteine: ['UGU', 'UGC'],
                  Tryptophan: 'UGG',
                  STOP: ['UAA', 'UAG', 'UGA'] }

  def self.of_codon(codon)
    AMINO_ACIDS.select do |_, codons|
      codons.include?(codon)
    end.keys.first.to_s
  end

  def self.of_rna(strand)
    codons = strand_to_colon(strand)
    proteins = []

    codons.each do |codon|
      raise InvalidCodonError if !valid?(codon)

      protein = of_codon(codon)
      break if protein == 'STOP'
      proteins << protein
    end

    proteins
  end

  def self.strand_to_colon(strand)
    strand.scan(/[A-Z]{3}/)
  end

  def self.valid?(codon)
    !codon.match(/[^ACGU]/)
  end
end

# top solutions
class InvalidCodonError < StandardError
end
#
module Translation
  CODON_PROTEIN = {
    'AUG' => 'Methionine',    'UUU' => 'Phenylalanine',
    'UUC' => 'Phenylalanine', 'UUA' => 'Leucine',
    'UUG' => 'Leucine',       'UCU' => 'Serine',
    'UCC' => 'Serine',        'UCA' => 'Serine',
    'UCG' => 'Serine',        'UAU' => 'Tyrosine',
    'UAC' => 'Tyrosine',      'UGU' => 'Cystine',
    'UGC' => 'Cystine',       'UGG' => 'Tryptophan',
    'UAA' => 'STOP',          'UAG' => 'STOP',
    'UGA' => 'STOP'
  }

  def self.of_codon(codon)
    CODON_PROTEIN.fetch(codon) { fail InvalidCodonError }
  end

  def self.of_rna(strand)
    strand.scan(/.../).take_while { |codon| of_codon(codon) != 'STOP' }
                      .map { |codon| of_codon(codon) }
  end
end

class InvalidCodonError < StandardError; end

class Translation
  CODONS = {
    'AUG' => 'Methionine',
    'UGG' => 'Tryptophan',
    'UUU' => 'Phenylalanine', 'UUC' => 'Phenylalanine',
    'UAU' => 'Tyrosine',      'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine',      'UGC' => 'Cysteine',
    'UUA' => 'Leucine',       'UUG' => 'Leucine',
    'UCU' => 'Serine',        'UCC' => 'Serine',
    'UCA' => 'Serine',        'UCG' => 'Serine',
    'UAA' => 'STOP',          'UAG' => 'STOP',
    'UGA' => 'STOP'
  }

  def self.of_codon(codon)
    CODONS.fetch(codon) { fail InvalidCodonError }
  end

  def self.of_rna(strand)
    codons = strand.scan(/.{3}/)
    codons.each_with_object([]) do |codon, rna|
      return rna if of_codon(codon) == 'STOP'
      rna << of_codon(codon)
    end
  end
end

class Translation
  PROTEIN_CODON = { "Methionine" => ["AUG"], "Phenylalanine" => ["UUU", "UUC"], "Leucine" => ["UUA", "UUG"],
                    "Serine" => ["UCU", "UCC", "UCA", "UCG"], "Tyrosine" => ["UAU", "UAC"],
                    "Cysteine" => ["UGU", "UGC"], "Tryptophan" => ["UGG"], "STOP" => ["UAA", "UAG", "UGA"]}

  def self.of_codon(codon)
    PROTEIN_CODON.select { |protein, codons| codons.include?(codon) }.keys.first
  end

  def self.of_rna(strand)
    strand.slice(0..8).scan(/.{3}/).take_while { |codon| !PROTEIN_CODON["STOP"].include?(codon) }.map do |codon|
      raise InvalidCodonError unless PROTEIN_CODON.values.flatten.include?(codon)
      of_codon(codon)
    end
  end
end

class InvalidCodonError < StandardError
end
