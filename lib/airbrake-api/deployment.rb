module AirbrakeAPI
  class Deployment < AirbrakeAPI::Base

    def self.find(*args)
      setup

      results = case args.first
        when Fixnum
          project_id = args.shift
          options = args.extract_options!
          fetch(collection_path(project_id), options)
        else
          raise AirbrakeError.new('Invalid argument')
      end

      raise AirbrakeError.new('No results found.') if results.nil?
      raise AirbrakeError.new(results.errors.error) if results.errors
      ['\n', nil].include?(results.projects) ? [] : results.projects.deploy
    end

    def self.collection_path(project_id)
      "/projects/#{project_id}/deploys.xml"
    end

  end
end