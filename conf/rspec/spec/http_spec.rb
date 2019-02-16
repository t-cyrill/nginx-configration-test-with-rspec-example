require 'faraday'
require 'json'

RSpec.describe "Request Host:http://nginx" do
  let(:target) { "http://nginx/" }
  subject do
    Faraday.get "#{target}"
  end

  context 'path:/example' do
    let(:target) { "http://nginx/example" }
    it 'returns status 301 http://example.local' do
      expect(subject.status).to eq(301)
      expect(subject.headers["location"]).to eq("http://example.local")
    end
  end

  context 'path:/foo/' do
    let(:target) { "http://nginx/foo/" }
    it 'returns status 200 ' do
      expect(subject.status).to eq(200)
      expect(JSON.parse(subject.body)["REQUEST_URI"]).to eq("http://upstream00:4567/foo/")
    end
  end

  context 'path:/01/' do
    let(:target) { "http://nginx/01/" }
    it 'returns status 200 ' do
      expect(subject.status).to eq(200)
      expect(JSON.parse(subject.body)["REQUEST_URI"]).to eq("http://upstream01:4567/01/")
    end
  end

  context 'path:/02/' do
    let(:target) { "http://nginx/02/" }
    it 'returns status 200 ' do
      expect(subject.status).to eq(200)
      expect(JSON.parse(subject.body)["REQUEST_URI"]).to eq("http://upstream02:4567/02/")
    end
  end
end
