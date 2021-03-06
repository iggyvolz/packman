class Hyrax_olfs < PACKMAN::Package
  url 'http://www.opendap.org/pub/olfs/olfs-1.11.3-webapp.tgz'
  sha1 '352aeadfdde441e67b263f0fe667cddd10d9e738'
  version '1.11.3'

  belongs_to 'hyrax'

  depends_on 'tomcat'

  label 'compiler_insensitive'

  def install
    PACKMAN.mkdir PACKMAN.prefix(self), :force
    PACKMAN.cp '.', PACKMAN.prefix(self)
    PACKMAN.cp "#{PACKMAN.prefix(self)}/opendap.war", "#{PACKMAN.prefix(Tomcat)}/webapps"
  end
end