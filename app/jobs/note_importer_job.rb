class NoteImporterJob
  @queue = :default

  def self.perform
    Notes::Importer.call
  end
end