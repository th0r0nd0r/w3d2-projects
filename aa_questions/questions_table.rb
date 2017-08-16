class QuestionsTable

  def self.find_by_id(id)
    table = self.tableize
    table = QuestionsDatabase.instance.execute(<<-SQL, table, id)
      SELECT
        *
      FROM
        ?
      WHERE
        id = ?
    SQL

    self.new(table.first)
  end

  def self.tableize
    self.class.to_s.tableize
  end
end
