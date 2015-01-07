# Jane
module Jane
  def self.config_file
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        '..', 'config', 'config.yml'
      )
    )
  end

  def self.config
    YAML.load_file(config_file)
  end
end
