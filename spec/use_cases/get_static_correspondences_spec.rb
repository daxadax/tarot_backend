require 'spec_helper'

class GetStaticCorrespondencesSpec < UseCaseSpec
  let(:result)  { UseCases::GetStaticCorrespondences.new.call }

  it 'returns static correspondences' do
    elemental = result.elemental

    assert_includes elemental['fire'], 'instinctual'
    assert_includes elemental['earth'], 'practical'
    assert_includes elemental['water'], 'emotional'
    assert_includes elemental['air'], 'communication'
  
    rank = result.rank

    assert_includes rank['minor13'], 'ambition'
    assert_includes rank['major13'], 'point of no return'

    astrological = result.astrological

    assert_includes astrological['saturn'], 'the end of cycles'
    assert_includes astrological['virgo'], 'health and illness'
  end
end
