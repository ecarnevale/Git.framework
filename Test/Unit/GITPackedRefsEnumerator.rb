describe "GITPackedRefsEnumerator" do
  before do
    @enumerator = GITPackedRefsEnumerator.enumeratorForRepo(default_repository)
  end

  should "not be nil" do
    @enumerator.should.not.be.nil
  end
  should "set packedRefsPath" do
    @enumerator.packedRefsPath.should.not.be.nil
  end
  should "set packedRefsPath to repo-root/packed-refs" do
    @enumerator.packedRefsPath.should == TEST_REPO_ROOT + '/packed-refs'
  end

  describe "-nextObject" do
    before do
      @object = @enumerator.nextObject
    end
    should "not be nil" do
      @object.should.not.be.nil
    end
    should "not start with #" do
      @object[0,1].should.not == '#'
    end
    should "have two parts" do
      sha1, name = @object.split(" ")
      sha1.length.should == 40
      name.should.not.be.nil
    end
  end
end
