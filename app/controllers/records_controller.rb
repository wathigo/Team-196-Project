# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :set_user
  before_action :set_user_record, only: %i[show update destroy]

  def index
    json_response(@user.records)
  end

  def show
    json_response(@record)
  end

  def create
    @user.records.create!(record_params)
    json_response(@user, :created)
  end

  def update
    @record.update(record_params)
    head :no_content
  end

  def destroy
    @record.destroy
    head :no_content
  end

  def update_records
    @record_update = Record.find(params[:id])
    @record_update.update(schedule_date: params[:schedule_date], specialist_id: params[:specialist_id])
  end
  private

  def record_params
    params.permit(:user_id, :specialist_id, :description, :diagnosis, :schedule_date)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_record
    @record = @user.records.find_by!(id: params[:id]) if @user
  end
end
