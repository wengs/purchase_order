require 'rails_helper'

describe POMilestoneGenerator do
  let(:po_milestone_generator) { described_class.new(po) }

  describe '#generate' do
    subject { po_milestone_generator.generate }

    context 'with a po' do
      let(:po_options) { {} }
      let(:po) { FactoryGirl.create(:po, po_options) }

      it 'is :item_created' do
        expect(subject).to eq :item_created
      end

      context 'when ready_for_quote' do
        let(:po_options) { { ready_for_quote: true } }

        it 'is :ready_for_quote' do
          expect(subject).to eq :ready_for_quote
        end
      end

      context 'when information_required' do
        let(:po_options) { { information_required: true } }

        it 'is :information_required' do
          expect(subject).to eq :information_required
        end
      end

      context 'when a quote is submitted' do
        let(:po_options) { { ready_for_quote: true, quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')) } }

        it 'is :quote_submitted' do
          expect(subject).to eq :quote_submitted
        end
      end

      context 'when a new graphic is added(graphic amended after a quote was uploaded)' do
        let(:po_options) { { graphic_amended: true, ready_for_quote: true, quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')) } }

        it 'is :graphic_amended' do
          expect(subject).to eq :graphic_amended
        end
      end

      context 'when graphic amended but information_required is checked' do
        let(:po_options) { {
          information_required: true,
          graphic_amended: true,
          quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png'))
        } }

        it 'is :information_required' do
          expect(subject).to eq :information_required
        end
      end

      context 'when a purchase order is uploaded' do
        let(:po_options) { {
          ready_for_quote: true,
          quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')),
          purchase_order: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png'))
        } }

        it 'is :po_provided' do
          expect(subject).to eq :po_provided
        end
      end

      context 'files needed after a quote is uploaded' do
        let(:po_options) { {
          files_needed: true,
          ready_for_quote: true,
          quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')),
        } }

        it 'is :files_needed' do
          expect(subject).to eq :files_needed
        end
      end

      context 'files needed after a purchase order is uploaded' do
        let(:po_options) { {
          files_needed: true,
          ready_for_quote: true,
          quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')),
          purchase_order: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png'))
        } }

        it 'is :files_needed' do
          expect(subject).to eq :files_needed
        end
      end

      context 'when in production' do
        let(:po_options) { {
          in_production: true,
          ready_for_quote: true,
          quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')),
          purchase_order: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png'))
        } }

        it 'is :in_production' do
          expect(subject).to eq :in_production
        end
      end

      context 'when shipped' do
        let(:po_options) { {
          shipped_at: Date.today,
          in_production: true,
          ready_for_quote: true,
          quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')),
          purchase_order: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png'))
        } }

        it 'is :shipped' do
          expect(subject).to eq :shipped
        end
      end

      context 'when shipped' do
        let(:po_options) { {
          delivered_at: Date.today,
          shipped_at: Date.today,
          in_production: true,
          ready_for_quote: true,
          quote: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png')),
          purchase_order: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.png'))
        } }

        it 'is :received' do
          expect(subject).to eq :received
        end
      end
    end
  end
end
