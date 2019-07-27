RSpec.shared_examples "an API Client" do
  it 'responds to #status' do
    expect(usecase).to respond_to(:status)
  end

  it 'responds to #errors' do
    expect(usecase).to respond_to(:errors)
  end

  it 'responds to .call' do
    expect(described_class).to respond_to(:call)
  end

  describe "#success?" do
    context "when status is :ok" do
      it "is true" do
        usecase.status = :ok
        expect(usecase.success?).to eq(true)
      end
    end

    context "when status is :created" do
      it "is true" do
        usecase.status = :created
        expect(usecase.success?).to eq(true)
      end
    end

    context "when status is :no_content" do
      it "is true" do
        usecase.status = :no_content
        expect(usecase.success?).to eq(true)
      end
    end

    context "when status is :unprocessable_entity" do
      it "is false" do
        usecase.status = :unprocessable_entity
        expect(usecase.success?).to eq(false)
      end
    end

    context "when status is :not_found" do
      it "is false" do
        usecase.status = :not_found
        expect(usecase.success?).to eq(false)
      end
    end
  end
end
