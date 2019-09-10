class I386JosElfGcc < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftp.gnu.org/gnu/gcc/gcc-9.2.0/gcc-9.2.0.tar.gz"
  sha256 "a931a750d6feadacbeecb321d73925cd5ebb6dfa7eff0802984af3aef63759f4"

  depends_on 'gcc' # will need to be changed to gcc@9 when next major version released
  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'isl'
  depends_on 'cloog'
  depends_on 'i386-jos-elf-binutils'

  def install
    mkdir 'build' do
      system "../configure", "--prefix=#{prefix}",
                             "--target=i386-jos-elf",
                             "--disable-werror",
                             "--disable-libssp",
                             "--disable-libmudflap",
                             "--disable-nls",
                             "--with-newlib",
                             "--with-as=#{Formula["i386-jos-elf-binutils"].opt_prefix}/bin/i386-jos-elf-as",
                             "--with-ld=#{Formula["i386-jos-elf-binutils"].opt_prefix}/bin/i386-jos-elf-ld",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}",
                             "--without-headers",
                             "--enable-languages=c",
                             "CC=/usr/local/bin/gcc-9",
                             "CXX=/usr/local/bin/g++-9"

      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"
    end
  end

  test do
    system "#{bin}/i386-jos-elf-gcc -v"
  end
end
