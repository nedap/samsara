require 'rails_helper'

describe Celebrity do

  let(:revision_class) { Samsara.revision_class }

  subject do
    Celebrity.new(first_name: "Brigitte", last_name: "Bardot", gender: 2, birth_date: Date.civil(1934,9,28))
  end

  it "is audited" do
    expect(Celebrity.is_audited?).to be true
  end

  context "after create" do
    context "while samsara is not active" do
      before do
        Samsara.disable!
        subject.save
      end

      it "does not create a revision" do
        expect(revision_class.count).to be 0
      end
    end

    context "while samsara is active" do
      before do
        Samsara.enable!
      end

      context "trying to save an invalid celebrity" do
        before do
          subject.gender = 3
          subject.save
        end

        it "does not create a revision" do
          expect(revision_class.count).to be 0
        end
      end

      context "saving a valid celebrity" do
        before do
          subject.save
        end

        it "creates a revision" do
          expect(revision_class.count).to be 1
        end

        context "the created revision" do
          let(:revision) { revision_class.first }

          it "is linked to the celebrity" do
            expect(revision.subject).to eq subject
          end

          it "has set the action" do
            expect(revision.action).to eq "create"
          end

          it "has stored the original attributes" do
            expect(revision.original_attributes).to eq({:birth_date=>nil, :first_name=>nil, :gender=>nil, :id=>nil, :last_name=>nil})
          end

          it "has stored the modified attributes" do
            expect(revision.modified_attributes).to eq(first_name: "Brigitte", last_name: "Bardot", gender: 2, birth_date: "1934-09-28", id: subject.id)
          end
        end
      end
    end
  end

  context "after update" do
    before do
      Samsara.disable!
      subject.save!
    end

    context "while samsara is not active" do
      before do
        subject.last_name = "Margot"
        subject.save!
      end

      it "does not create a revision" do
        expect(revision_class.count).to be 0
      end
    end

    context "while samsara is active" do

      before do
        Samsara.enable!
      end

      context "not changing the celebrity" do
        before do
          subject.save!
        end

        it "does not create a revision" do
          expect(revision_class.count).to be 0
        end
      end

      context "trying to save an invalid celebrity" do
        before do
          subject.gender = 3
          subject.save
        end

        it "does not create a revision" do
          expect(revision_class.count).to be 0
        end
      end

      context "changing the celebrity" do
        before do
          subject.last_name = "Margot"
          subject.save
        end

        it "creates a revision" do
          expect(revision_class.count).to be 1
        end

        context "the created revision" do
          let(:revision) { revision_class.first }

          it "is linked to the celebrity" do
            expect(revision.subject).to eq subject
          end

          it "has set the action" do
            expect(revision.action).to eq "update"
          end

          it "has stored the original attributes" do
            expect(revision.original_attributes).to eq(last_name: "Bardot")
          end

          it "has stored the modified attributes" do
            expect(revision.modified_attributes).to eq(first_name: "Brigitte", last_name: "Margot", gender: 2, birth_date: "1934-09-28", id: subject.id)
          end
        end
      end
    end
  end

  context "after destroy" do
    before do
      Samsara.disable!
      subject.save!
    end

    context "while samsara is not active" do
      before do
        subject.destroy!
      end

      it "does not create a revision" do
        expect(revision_class.count).to be 0
      end
    end

    context "while samsara is active" do
      before do
        Samsara.enable!
      end

      context "failing to destroy" do
        before do
          allow(subject).to receive(:destroy).and_return false
          subject.destroy
        end

        it "does not create a revision" do
          expect(revision_class.count).to be 0
        end
      end

      context "successfully destroying the celebrity" do
        before do
          subject.destroy!
        end

        it "creates a revision" do
          expect(revision_class.count).to be 1
        end

        context "the created revision" do
          let(:revision) { revision_class.first }

          it "is linked to the celebrity" do
            expect(revision.subject_type).to eq "Celebrity"
            expect(revision.subject_id).to eq subject.id
          end

          it "has set the action" do
            expect(revision.action).to eq "destroy"
          end

          it "has stored the original attributes" do
            expect(revision.original_attributes).to eq({:birth_date=>nil, :first_name=>nil, :gender=>nil, :id=>nil, :last_name=>nil})
          end

          it "has stored the modified attributes" do
            expect(revision.modified_attributes).to eq(first_name: "Brigitte", last_name: "Bardot", gender: 2, birth_date: "1934-09-28", id: subject.id)
          end
        end
      end
    end
  end

end
