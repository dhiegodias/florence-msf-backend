class AddAgendaIdToStakeholder < ActiveRecord::Migration[7.0]
  def change
    add_column :stakeholders, :agenda_id, :integer
  end
end
