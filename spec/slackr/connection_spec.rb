require 'spec_helper'

describe Slackr::Connection do

  # -----------------------------------
  # new
  # -----------------------------------
  describe "#new" do
    context "with invalid parameters" do
      it "raises an exception when token is nil" do
        expect {
          Slackr::Connection.new('token')
        }.to raise_error(Slackr::ArgumentError, 'token required')
      end

      it "raises an exception when token is blank" do
        expect {
          Slackr::Connection.new('', 'token', 'username')
        }.to raise_error(Slackr::ArgumentError, 'token required')
      end
    end


    context "with valid parameters" do
      it "returns an instance of Slackr::Connection"
    end
  end

  # -----------------------------------
  # request
  # -----------------------------------
  describe "#request" do
    it "includes the token in each request"

    it "makes the request against the domain with the team name as the subdomain"
  end
end
