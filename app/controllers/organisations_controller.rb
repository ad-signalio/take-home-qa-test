# frozen_string_literal: true

class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[show edit update destroy]

  add_breadcrumb 'Organisations', :organisations_path
  add_breadcrumb :current_organisation_name, :current_organisation, only: %i[show edit]
  add_breadcrumb 'New organisation', nil, only: %i[new create]
  add_breadcrumb 'Edit', nil, only: :edit

  def index
    @organisations = Organisation.all
  end

  def show; end

  def new
    @organisation = Organisation.new
  end

  def edit; end

  def create
    @organisation = Organisation.new(organisation_params)

    if @organisation.save
      redirect_to @organisation, notice: 'Organisation was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organisations/1 or /organisations/1.json
  def update
    if @organisation.update(organisation_params)
      redirect_to @organisation, notice: 'Organisation was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /organisations/1 or /organisations/1.json
  def destroy
    @organisation.destroy
    redirect_to organisations_url, notice: 'Organisation was successfully destroyed.'
  end

  private

  def set_organisation
    @organisation = Organisation.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(:name)
  end

  def current_organisation
    @current_organisation ||= Organisation.find(params[:id])
  end

  def current_organisation_name
    current_organisation.name
  end

  helper_method :current_organisation, :current_organisation_name
end
