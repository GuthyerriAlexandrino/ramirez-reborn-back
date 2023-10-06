# frozen_string_literal: true

# Controller for handling specializations
class SpecializationsController < ApplicationController
  # before_action: authorize request, except for the index action
  before_action :authorize_request, except: :index
  before_action :set_specialization, only: %i[show]

  # GET /specializations
  # return all specializations
  def index
    @specializations = Specialization.all
    render json: @specializations
  end

  # GET /specializations/1
  # Return a Specialization
  # @return [Hash<Specialization>]
  def show
    render json: @specialization
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_specialization
    @specialization = Specialization.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def specialization_params
    params.require(:specialization).permit(:name, :string)
  end
end
