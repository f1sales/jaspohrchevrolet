require 'ostruct'

RSpec.describe F1SalesCustom::Hooks::Lead do
  context "when product is from Global Connect" do
    let(:lead) do
      lead = OpenStruct.new
      lead.source = source
      lead.message = ''
      lead.description = ''

      lead
    end

    let(:source) do
      source = OpenStruct.new
      source.name = 'GM - Santa Cruz'

      source
    end

    let(:switch_source) { described_class.switch_source(lead) }

    context 'when is a Oficina lead' do
      before do
        lead.description = 'Concessionária: J. A. Spohr; Local: LAJEADO; Consulta: Agendamento de Serviços; Oportunidade: Pós-Vendas; Campanha: OPS - ONSTAR - ALERTA DE REVISÃO WHATSAPP'
      end

      it 'returns GM - Santa Cruz - Oficina' do
        expect(switch_source).to eq('GM - Santa Cruz - Oficina')
      end
    end

    context 'when is a different source' do
      before do
        source.name = 'Different Source'
        lead.message = 'REDE DIGITAL - SEMINOVOS'
      end

      context 'when there is SEMINOVOS in message' do
        it 'returns source_name - SEMINOVOS' do
          expect(switch_source).to eq('Different Source - SEMINOVOS')
        end
      end

      context 'when there is no SEMINOVOS in message' do
        before { lead.message = '' }

        it 'returns only source_name' do
          expect(switch_source).to eq('Different Source')
        end
      end
    end
  end
end
