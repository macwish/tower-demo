class TeamsController < ApplicationController

  before_action :set_team, only: [:show]

  def list
    @title = "Team/List"

    members = current_user.team_members
    team_ids = members.map do |member|
      member.team_id
    end
    team_ids = team_ids || []
    @teams = Team.where(id: [team_ids])
  end

  def show
    @title = "Team/Show - #{@team.name}"
  end

  private

    def set_team
      @team = Team.find(params[:id])
    end

end
