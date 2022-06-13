require 'ostruct'

RSpec.describe F1SalesCustom::Hooks::Lead do
  context "when product comes from Global Conect" do
    let(:lead) do
      lead = OpenStruct.new
      lead.source = source
      lead.message = 'REDE DIGITAL - SEMINOVOS'

      lead
    end

    let(:source) do
      source = OpenStruct.new
      source.name = 'Global Connect - Santa Cruz'

      source
    end

    it 'when message contains REDE DIGITAL - SEMINOVOS' do
      expect(described_class.switch_source(lead)).to eq('Global Connect - Santa Cruz - REDE DIGITAL - SEMINOVOS')
    end

  end
  
end