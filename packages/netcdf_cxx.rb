class Netcdf_cxx < PACKMAN::Package
  url 'https://github.com/Unidata/netcdf-cxx4/archive/v4.2.1.tar.gz'
  sha1 '0bb4a0807f10060f98745e789b6dc06deddf30ff'
  version '4.2.1'

  belongs_to 'netcdf'

  option 'use_mpi' => :package_name

  depends_on 'netcdf_c'

  def install
    netcdf_c_prefix = PACKMAN.prefix(Netcdf_c)
    PACKMAN.append_env "PATH=#{netcdf_c_prefix}/bin:$PATH"
    PACKMAN.append_env "CPPFLAGS='-I#{netcdf_c_prefix}/include'"
    PACKMAN.append_env "LDFLAGS='-L#{netcdf_c_prefix}/lib'"
    args = %W[
      --prefix=#{PACKMAN.prefix(self)}
      --disable-dependency-tracking
      --disable-dap-remote-tests
      --enable-static
      --enable-shared
    ]
    PACKMAN.run './configure', *args
    PACKMAN.run 'make'
    PACKMAN.run 'make check' if not skip_test?
    PACKMAN.run 'make install'
    PACKMAN.clean_env
  end
end
