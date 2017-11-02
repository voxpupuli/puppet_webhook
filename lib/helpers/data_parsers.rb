require 'shellwords'

module DataParsers # rubocop:disable Style/Documentation
  def sanitize_input(input_string)
    sanitized = Shellwords.shellescape(input_string)
    LOGGER.info("Module or Branch name #{sanitized} had to be escaped") unless input_string == sanitized
    sanitized
  end

  def normalize(str)
    settings.allow_uppercase ? str : str.downcase
  end

  def verify_signature(payload_body)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), settings.github_secret, payload_body)
    throw(:halt, [500, "Signatures didn't match!\n"]) unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

  # rubocop:disable Style/RescueModifier
  # TODO: Move the code from these methods to our parser class
  def repo_name(data)
    # Only tested with Github
    # TODO: Extend for Bitbucket, Bitbucket Server, and Gitlab
    data['repository']['name'] rescue nil
  end

  def repo_user(data)
    # Only tested with Github
    # TODO: Extend for Bitbucket, Bitbucket Server, and Gitlab
    data['repository']['owner']['login'] rescue nil
  end
  # rubocop:enable Style/RescueModifier
end
