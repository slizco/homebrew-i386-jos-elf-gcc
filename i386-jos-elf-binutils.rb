class I386JosElfBinutils < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftp.gnu.org/gnu/binutils/binutils-2.32.tar.gz"
  sha256 "9b0d97b3d30df184d302bced12f976aa1e5fbf4b0be696cdebc6cca30411a46e"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-jos-elf",
                          "--disable-werror",
                          "--disable-nls"
    system "make"
    system "make", "install"
    # avoid conflict with gdb
    if Formula["i386-jos-elf-gdb"].installed?
      rm_r share/"info"
    end
  end

  test do
    system "#{bin}/i386-jos-elf-objdump -i"
  end
end
