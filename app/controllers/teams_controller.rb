# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_organisation
  before_action :set_team, only: %i[show edit update destroy]

  add_breadcrumb 'Organisations', :organisations_path
  add_breadcrumb :current_organisation_name, :current_organisation, only: %i[show edit new create]
  add_breadcrumb :current_team_name, ->(v) { [v.current_organisation, v.current_team] }, only: %i[show edit]
  add_breadcrumb 'New team', nil, only: %i[new create]
  add_breadcrumb 'Edit', nil, only: :edit

  def show; end

  def new
    @team = @organisation.teams.new
  end

  def edit; end

  def create
    @team = @organisation.teams.new(team_params)

    if @team.save
      redirect_to [@organisation, @team], notice: 'Team was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      redirect_to [@organisation, @team], notice: 'Team was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    redirect_to organisation_path(@organisation), notice: 'Team was successfully destroyed.'
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def set_organisation
    @organisation = Organisation.find(params[:organisation_id])
  end

  def current_organisation
    @current_organisation ||= Organisation.find(params[:organisation_id])
  end

  def current_organisation_name
    current_organisation.name
  end

  def current_team
    @current_team ||= Team.find(params[:id])
  end

  def current_team_name
    current_team.name
  end

  helper_method :current_organisation, :current_team, :current_organisation_name, :current_team_name

  def team_params
    params.require(:team).permit(:name)
  end
end
