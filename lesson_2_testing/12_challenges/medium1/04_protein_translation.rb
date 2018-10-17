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
   codon -> protein: hash or regex?

a: rna strands into codons:
   slice strand into 3 character codons (strand_to_colon)
   for each codons,
     raise InvalidColonError if invalid colon
     look up the protein  (of_codon)
     add protein to array
   output array

   codon into protein (of_codon)


=end

class TranslationTest
  def self.of_codon(codon)
    # UUU of zo in, 'Leucine' codons, Serine codons etc uit
    'protein'
  end

  def self.of_rna(strand)
    # strand 'AUGUUUUGG' in , protein Methionine etc uit
    codons = strand_to_colon(strand)
    codons.each.with_object([]) do |codon, proteins|
      raise "InvalidCodonError" if !colon.valid?
      proteins << of_codon(codon)
    end
  end

  def self.strand_to_colon(strand)
    codons = strand.scan(/[A-Z]{3}/)
  end

  def self.valid?(codon)
    !codon.match(/[^ACGU]/)
  end

end

p TranslationTest.of_rna('AUGUUUUGG')
p TranslationTest.valid?('AUG')
p TranslationTest.valid?('ZUG')