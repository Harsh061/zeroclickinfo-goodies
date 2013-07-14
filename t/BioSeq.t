#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use DDG::Test::Goodie;

zci is_cached => 1;
zci answer_type => 'bioseq';

my $test_seq = "TTTATAAGAAACAAAAAAAAGAAAUAAAAAATGAGTAATACTTCUUCGTACGAGAAGAATAATCCAGATAATCTGAAACACAAUGGTATTACCATAGATTCTGAGTUUCTAACTCAGGAGCCAATAACCATTCCCTCAAATGGCTCCGCTGTTTCTATTGACGAAACAGGTTCAGGGTCCAAATGGCAAGACTTTAAAGATTCTTTCAAAAGGGTAAAACCTATTGAAGTTGATCCTAATCTTTCAGAAGCTGAAAAAGTGGCTATCATCACTGCCCAAACTCCATTGAAGCACCACTTGAAGAATAGACATTTGCAAATGATTGCCATCGGTGGTGCCATCGGTACTGGTCTGCTGGTTGGGTCAGGTACTGCACTAAGAACAGGTGGTCCCGCTTCGCTACTGATTGGATGGGGGTC";
#GAP1 from -30 to +190, with some T's -> U's from yeastgenome.org

ddg_goodie_test(
	['DDG::Goodie::BioSeq'],
	'bioseq c '.$test_seq 		=> test_zci("Complement: AAATATTCTTTGTTTTTTTTCTTTATTTTTTACTCATTATGAAGAAGCATGCTCTTCTTATTAGGTCTATTAGACTTTGTGTTACCATAATGGTATCTAAGACTCAAAGATTGAGTCCTCGGTTATTGGTAAGGGAGTTTACCGAGGCGACAAAGATAACTGCTTTGTCCAAGTCCCAGGTTTACCGTTCTGAAATTTCTAAGAAAGTTTTCCCATTTTGGATAACTTCAACTAGGATTAGAAAGTCTTCGACTTTTTCACCGATAGTAGTGACGGGTTTGAGGTAACTTCGTGGTGAACTTCTTATCTGTAAACGTTTACTAACGGTAGCCACCACGGTAGCCATGACCAGACGACCAACCCAGTCCATGACGTGATTCTTGTCCACCAGGGCGAAGCGATGACTAACCTACCCCCAG"),
	'bioseq r '.$test_seq 		=> test_zci("Reversed: CTGGGGGTAGGTTAGTCATCGCTTCGCCCTGGTGGACAAGAATCACGTCATGGACTGGGTTGGTCGTCTGGTCATGGCTACCGTGGTGGCTACCGTTAGTAAACGTTTACAGATAAGAAGTTCACCACGAAGTTACCTCAAACCCGTCACTACTATCGGTGAAAAAGTCGAAGACTTTCTAATCCTAGTTGAAGTTATCCAAAATGGGAAAACTTTCTTAGAAATTTCAGAACGGTAAACCTGGGACTTGGACAAAGCAGTTATCTTTGTCGCCTCGGTAAACTCCCTTACCAATAACCGAGGACTCAATCTTTGAGTCTTAGATACCATTATGGTAACACAAAGTCTAATAGACCTAATAAGAAGAGCATGCTTCTTCATAATGAGTAAAAAATAAAGAAAAAAAACAAAGAATATTT"),
	'bioseq r MSNTSSYEKNNPDN'	=> test_zci("Reversed: NDPNNKEYSSTNSM"),
	'bioseq rc '.$test_seq 	=> test_zci("Reversed complement: GACCCCCATCCAATCAGTAGCGAAGCGGGACCACCTGTTCTTAGTGCAGTACCTGACCCAACCAGCAGACCAGTACCGATGGCACCACCGATGGCAATCATTTGCAAATGTCTATTCTTCAAGTGGTGCTTCAATGGAGTTTGGGCAGTGATGATAGCCACTTTTTCAGCTTCTGAAAGATTAGGATCAACTTCAATAGGTTTTACCCTTTTGAAAGAATCTTTAAAGTCTTGCCATTTGGACCCTGAACCTGTTTCGTCAATAGAAACAGCGGAGCCATTTGAGGGAATGGTTATTGGCTCCTGAGTTAGAAACTCAGAATCTATGGTAATACCATTGTGTTTCAGATTATCTGGATTATTCTTCTCGTACGAAGAAGTATTACTCATTTTTTATTTCTTTTTTTTGTTTCTTATAAA"),
	'bioseq tln '.$test_seq	=> test_zci("Translated to amino acid sequence:

\tFrame 1: FIRNKKKK {STOP} K {START} MSNTSSYEKNNPDNLKHNGITIDSEFLTQEPITIPSNGSAVSIDETGSGSKWQDFKDSFKRVKPIEVDPNLSEAEKVAIITAQTPLKHHLKNRHLQMIAIGGAIGTGLLVGSGTALRTGGPASLLIGWG

\tFrame 2: L {STOP} ETKKRNKK {STOP} VILLRTRRIIQII {STOP} NT {START} MVLP {STOP} ILSF {STOP} LRSQ {STOP} PFPQ {START} MAPLFLLTKQVQGPNGKTLKILSKG {STOP} NLLKLILIFQKLKKWLSSLPKLH {STOP} STT {STOP} RIDICK {STOP} LPSVVPSVLVCWLGQVLH {STOP} EQVVPLRY {STOP} LDGG

\tFrame 3: YKKQKKEIKNE {STOP} YFFVREE {STOP} SR {STOP} SETQWYYHRF {STOP} VSNSGANNHSLKWLRCFY {STOP} RNRFRVQ {START} MARL {STOP} RFFQKGKTY {STOP} S {STOP} S {STOP} SFRS {STOP} KSGYHHCPNSIEAPLEE {STOP} TFANDCHRWCHRYWSAGWVRYCTKNRWSRFATDW {START} MGV"),
	'bioseq t '.$test_seq 	=> test_zci("Estimated melting temperature of 79.9300715990453 Celsius, supposing 50mM monovalent cations."),
	'bioseq temp TAATACGACTCACTATAGGG' => test_zci("Estimated melting temperature of 47.68 Celsius, supposing 50mM monovalent cations."),
	'bioseq temp TAATACGA' => test_zci("Estimated melting temperature of 20 Celsius, supposing 50mM monovalent cations."),
	'bioseq temp MSNTSSYEKNNPDN' => test_zci("Estimated melting temperature of [ERROR: Non-nucleotide characters detected] Celsius, supposing 50mM monovalent cations."),
	'bioseq w '.$test_seq 	=> test_zci("That sequence, as DNA without a 5' phosphate, would weigh 129631.8 grams per mole."),
);

done_testing;
