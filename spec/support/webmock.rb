WebMock.disable_net_connect!

module WebMockHelpers
  # Returns a File for the fixture named `filename`.
  def fixture(filename)
    File.read("#{fixture_path}/#{filename}")
  end

  # Returns a Pathname for the fixtures folder.
  def fixtures_path
    Pathname.new(File.expand_path('../fixtures', __dir__))
  end

  # Returns a String response from the `filename` fixture.
  def fixture_response(filename)
    filename = filename.sub(%r{^/}, '')
    File.read(fixtures_path.join('responses', filename))
  end

  def fixture_response_from_template(filename)
    ERB.new(fixture_response(filename)).result(yield)
  end

  # Returns a gzipped String response form the `filename` fixture.
  def gzipped_fixture_response(filename)
    gzip(fixture_response(filename))
  end

  %i[delete get head patch post put].each do |verb|
    define_method("a_#{verb}") do |path|
      a_request(verb, path)
    end

    define_method("stub_#{verb}") do |path|
      stub_request(verb, path)
    end
  end
end

RSpec.configure do |config|
  config.include WebMockHelpers
end
