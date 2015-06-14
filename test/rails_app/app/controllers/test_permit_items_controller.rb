class TestPermitItemsController < ApplicationController
  mongosteen

  private

  def test_permit_item_params
    params.require(:test_permit_item).permit(:title)
  end
end
