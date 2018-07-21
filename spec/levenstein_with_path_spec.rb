# encoding: UTF-8

describe 'LevensteinWithPath' do
  # Some real tests:
  let(:kitten_to_sitting) { LevensteinWithPath::Path.new('kitten', 'sitting') }
  let(:saturday_to_sunday) { LevensteinWithPath::Path.new('Saturday', 'Sunday') }

  # Non-ascii:
  let(:eye_to_navel) { LevensteinWithPath::Path.new("ὀφθαλμός", "ὀμφαλός") }

  # Some degenerate cases:
  let(:cat_to_empty) { LevensteinWithPath::Path.new('cat', '') }
  let(:empty_to_cat) { LevensteinWithPath::Path.new('', 'cat') }
  let(:empty_to_empty) { LevensteinWithPath::Path.new('', '') }
  let(:a_to_a) { LevensteinWithPath::Path.new('a', 'a') }
  let(:cat_to_cat) { LevensteinWithPath::Path.new('cat', 'cat') }

  # Arrays of words:
  let(:vita_ad_spes) { LevensteinWithPath::Path.new(%w[Dum vita est], %w[spes est]) }

  it "computes the score" do
    expect(kitten_to_sitting.score).to eq 3
    expect(saturday_to_sunday.score).to eq 3

    expect(eye_to_navel.score).to eq 3

    expect(cat_to_empty.score).to eq 3
    expect(empty_to_cat.score).to eq 3
    expect(empty_to_empty.score).to eq 0
    expect(a_to_a.score).to eq 0
    expect(cat_to_cat.score).to eq 0

    expect(vita_ad_spes.score).to eq 2
  end

  it "lists the edits" do
    expect(kitten_to_sitting.edits).to eq [
      LevensteinWithPath::Swap.new('k', 's'),
      LevensteinWithPath::Keep.new('i'),
      LevensteinWithPath::Keep.new('t'),
      LevensteinWithPath::Keep.new('t'),
      LevensteinWithPath::Swap.new('e', 'i'),
      LevensteinWithPath::Keep.new('n'),
      LevensteinWithPath::Insert.new('g'),
    ]
    expect(saturday_to_sunday.edits).to eq [
      LevensteinWithPath::Keep.new('S'),
      LevensteinWithPath::Delete.new('a'),
      LevensteinWithPath::Delete.new('t'),
      LevensteinWithPath::Keep.new('u'),
      LevensteinWithPath::Swap.new('r', 'n'),
      LevensteinWithPath::Keep.new('d'),
      LevensteinWithPath::Keep.new('a'),
      LevensteinWithPath::Keep.new('y'),
    ]

    expect(eye_to_navel.edits).to eq [
      LevensteinWithPath::Keep.new('ὀ'),
      LevensteinWithPath::Swap.new('φ', 'μ'),
      LevensteinWithPath::Swap.new('θ', 'φ'),
      LevensteinWithPath::Keep.new('α'),
      LevensteinWithPath::Keep.new('λ'),
      LevensteinWithPath::Delete.new('μ'),
      LevensteinWithPath::Keep.new('ό'),
      LevensteinWithPath::Keep.new('ς'),
    ]

    expect(cat_to_empty.edits).to eq %w[c a t].map{|x| LevensteinWithPath::Delete.new(x)}
    expect(empty_to_cat.edits).to eq %w[c a t].map{|x| LevensteinWithPath::Insert.new(x)}
    expect(empty_to_empty.edits).to eq []
    expect(a_to_a.edits).to eq [LevensteinWithPath::Keep.new('a')]
    expect(cat_to_cat.edits).to eq %w[c a t].map{|x| LevensteinWithPath::Keep.new(x)}

    expect(vita_ad_spes.edits).to eq [
      LevensteinWithPath::Delete.new('Dum'),
      LevensteinWithPath::Swap.new('vita', 'spes'),
      LevensteinWithPath::Keep.new('est'),
    ]
  end
end
