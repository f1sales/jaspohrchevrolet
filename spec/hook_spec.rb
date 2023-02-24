require 'ostruct'

RSpec.describe F1SalesCustom::Hooks::Lead do
  context "when product is from Global Connect" do
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

    context 'when message is empty' do
      before { lead.message = nil }
      it 'when message contains REDE DIGITAL - SEMINOVOS' do
        expect(described_class.switch_source(lead)).to eq('GC - Santa Cruz')
      end
    end

    context 'when message is not empty' do
      it 'when message contains REDE DIGITAL - SEMINOVOS' do
        expect(described_class.switch_source(lead)).to eq('GC - Santa Cruz - REDE DIGITAL - SEMINOVOS')
      end
    end

    context 'when is not from Global Connect' do
      before do
        source.name = 'Different Source'
      end

      context 'when there is SEMINOVOS in message' do
        it 'returns source_name - SEMINOVOS' do
          expect(described_class.switch_source(lead)).to eq('Different Source - SEMINOVOS')
        end
      end

      context 'when there is no SEMINOVOS in message' do
        before { lead.message = '' }

        it 'returns only source_name' do
          expect(described_class.switch_source(lead)).to eq('Different Source')
        end
      end
    end
  end
end
