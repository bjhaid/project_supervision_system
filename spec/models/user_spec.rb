require 'spec_helper'

describe User do
    before {@user = User.new(name: "Example User", matric_no:"AUO/**/***", email:"user@example.com")}
    subject { @user }
    it {should respond_to(:name)}
    it {should respond_to(:matric_no)}
    it {should respond_to(:email)}

    it { should be_valid }
    describe "when name is not present" do
        before {@user.name= " " }
        it { should_not be_valid }
    end

    describe "when name is too long" do
        before {@user.name = "a" * 51 }
        it { should_not be_valid}
    end

    describe "when matric number is not present" do
        before {@user.matric_no= " "}
        it {should_not be_valid }
    end

    describe "when matric_number format is invalid" do
        it "should be valid"
        numbers= %w[AUO/00/ AUO/0/111 AUO/00/11]
        numbers.each do |invalid_number|
            @user.matric_no = invalid_number
            expect(@user).not_to be_valid
        end
    end

    describe "when matric number format is valid" do
        it "should be valid" do
            numbers = %w[AUO/11/794]
            numbers.each do |valid_number|
                @user.matric_no = valid_number
                expect(@user).to be_valid
            end
        end
    end

    describe "when email is not present" do
        before {@user.email= " "}
        it {should_not be_valid}
    end

    describe "when email format is invalid" do
        it "should be valid "
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                             foo@bar_baz.com foo@bar+baz.com]
            addresses.each do |invalid_address|
            @user.email = invalid_address
            expect(@user).not_to be_valid
        end
    end

    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |valid_address|
                @user.email = valid_address
                expect(@user).to be_valid
            end
        end
    end
    describe "when email address is already taken" do
        before do
            user_with_same_email = @user.dup
            user_with_same_email = @user.email.upcase
            user_with_same-email.save
        end
        it {should_not be_valid}
    end
end