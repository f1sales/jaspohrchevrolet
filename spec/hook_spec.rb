require 'ostruct'

RSpec.describe F1SalesCustom::Hooks::Lead do
  context "when product is from Global Connect" do
    let(:lead) do
      lead = OpenStruct.new
      lead.source = source
      lead.message = 'REDE DIGITAL - SEMINOVOS'
      lead.product = product

      lead
    end

    let(:source) do
      source = OpenStruct.new
      source.name = 'Global Connect - Santa Cruz'

      source
    end

    let(:product) do
      product = OpenStruct.new
      product.name = 'Tracker'

      product
    end

    context 'when product come from Global Connect' do
      it 'when message contains REDE DIGITAL - SEMINOVOS' do
        expect(described_class.switch_source(lead)).to eq('GC - Santa Cruz - REDE DIGITAL - SEMINOVOS - Tracker')
      end
    end

    context 'when message is empty and product is not' do
      before { lead.message = nil }
      it 'when message contains REDE DIGITAL - SEMINOVOS' do
        expect(described_class.switch_source(lead)).to eq('GC - Santa Cruz - Tracker')
      end
    end

    context 'when product is empty and message is not' do
      before { lead.product.name = nil }
      it 'when message contains REDE DIGITAL - SEMINOVOS' do
        expect(described_class.switch_source(lead)).to eq('GC - Santa Cruz - REDE DIGITAL - SEMINOVOS')
      end
    end

    context 'when is not from Global Connect' do
      before do
        source.name = 'Different Source'
      end

      it 'is not from Global Connect' do
        expect(described_class.switch_source(lead)).to eq('Different Source')
      end
    end
  end
end
