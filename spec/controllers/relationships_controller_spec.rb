require 'spec_helper'

describe RelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in(user) }

  describe "create a relationship with ajax" do
    it "decrement the relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.should change(Relationship, :count).by(1)
    end
  end

  describe "destroying a relationship with ajax" do

    before { user.follow!(other_user) }
    let(:relationship) { user.relationships.find_by_followed_id(other_user) }

    it "should destroy a relationship using ajax" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.should change(Relationship, :count).by(-1)
    end
  end
end
