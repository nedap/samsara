require 'rails_helper'

describe CelebritiesController, type: :request do
  let(:context_class) { Samsara.context_class }
  let(:revision_class) { Samsara.revision_class }

  let(:celebrity_params) do
    { first_name: "Brigitte", last_name: "Bardot", gender: "2", birth_date: "1934-9-28" }
  end

  context "while samsara is not active" do
    before do
      Samsara.disable!
      post(celebrities_path, params: {celebrity: celebrity_params})
    end

    it "does not create a context" do
      expect(context_class.count).to eq 0
    end

    it "does not create a revision" do
      expect(revision_class.count).to eq 0
    end
  end

  context "while samsara is active" do
    before do
      Samsara.enable!
    end

    context "requesting the index" do
      before do
        get(celebrities_path)
      end

      it "does not create a context" do
        expect(context_class.count).to eq 0
      end

      it "does not create a revision" do
        expect(revision_class.count).to eq 0
      end
    end

    context "creating an invalid celebrity" do
      before do
        post(celebrities_path, params: {celebrity: celebrity_params.merge(gender: 3)})
      end

      it "does not create a context" do
        expect(context_class.count).to eq 0
      end

      it "does not create a revision" do
        expect(revision_class.count).to eq 0
      end
    end

    context "creating a single celebrity" do
      before do
        post(celebrities_path, params: {celebrity: celebrity_params, password: "supersecret"})
      end

      it "creates a context" do
        expect(context_class.count).to eq 1
      end

      it "creates a revision" do
        expect(revision_class.count).to eq 1
      end

      context "the created context" do
        let(:context) { context_class.first }

        let(:expected_params) do
          { celebrity: celebrity_params, password: "[FILTERED]", controller: "celebrities", action: "create" }
        end

        it "has set the application name" do
          expect(context.application_name).to eq "Dummy"
        end

        it "has set the environment name" do
          expect(context.environment_name).to eq "test"
        end

        it "has set the http request as the event" do
          expect(context.event).to be_a Samsara::HttpRequest
          expect(context.event.method).to eq "POST"
          expect(context.event.url).to eq celebrities_path
          expect(context.event.params).to eq(expected_params)
        end

        it "has been linked to the revision" do
          expect(context.revisions.count).to eq 1
        end
      end
    end

    context "creating multiple celebrities" do
      before do
        post(multiply_celebrities_path, params: {celebrity: celebrity_params, password: "supersecret"})
      end

      it "creates a context" do
        expect(context_class.count).to eq 1
      end

      it "creates multiple revisions" do
        expect(revision_class.count).to eq 2
      end

      context "the created context" do
        let(:context) { context_class.first }

        it "has been linked to all the revisions" do
          expect(context.revisions.count).to eq 2
        end
      end
    end
  end
end
