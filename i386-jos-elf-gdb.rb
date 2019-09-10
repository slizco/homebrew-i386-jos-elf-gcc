class I386JosElfGdb < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.gz"
  sha256 "b2266ec592440d0eec18ee1790f8558b3b8a2845b76cc83a872e39b501ce8a28"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-jos-elf",
                          "--program-prefix=i386-jos-elf-",
                          "--disable-nls",
                          "--disable-werror"
    system "make", "all"
    system "make", "install"
    # avoid conflict with binutils
    if Formula["i386-jos-elf-binutils"].installed?
      rm_r share/"info"
    end
  end

  test do
    system "#{bin}/i386-jos-elf-gdb -v"
  end
end
