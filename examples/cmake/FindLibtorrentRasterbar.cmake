# - Try to find libtorrent-rasterbar
# Once done this will define
#  LibtorrentRasterbar_FOUND - System has libtorrent-rasterbar
#  LibtorrentRasterbar_INCLUDE_DIRS - The libtorrent-rasterbar include directories
#  LibtorrentRasterbar_LIBRARIES - The libraries needed to use libtorrent-rasterbar
#  LibtorrentRasterbar_DEFINITIONS - Compiler switches required for using libtorrent-rasterbar

find_package(PkgConfig)
pkg_check_modules(PC_LIBTORRENT_RASTERBAR libtorrent-rasterbar)

if (PC_LIBTORRENT_RASTERBAR_FOUND)
    set(LibtorrentRasterbar_DEFINITIONS ${PC_LIBTORRENT_RASTERBAR_CFLAGS})
else ()
    # Without pkg-config, we can't possibly figure out the correct build flags.
    # libtorrent is very picky about those. Let's take a set of defaults and
    # hope that they apply. If not, you the user are on your own.
    set(LibtorrentRasterbar_DEFINITIONS -DTORRENT_USE_OPENSSL -DTORRENT_DISABLE_GEO_IP -DTORRENT_LINKING_SHARED -DBOOST_ASIO_DYN_LINK -DBOOST_ASIO_ENABLE_CANCELIO -DBOOST_EXCEPTION_DISABLE -DBOOST_DATE_TIME_DYN_LINK -DBOOST_THREAD_DYN_LINK -DBOOST_SYSTEM_DYN_LINK -DBOOST_CHRONO_DYN_LINK -DUNICODE -D_UNICODE -D_FILE_OFFSET_BITS=64)
endif ()

find_path(LibtorrentRasterbar_INCLUDE_DIR libtorrent
          HINTS ${PC_LIBTORRENT_RASTERBAR_INCLUDEDIR} ${PC_LIBTORRENT_RASTERBAR_INCLUDE_DIRS}
          PATH_SUFFIXES libtorrent-rasterbar)

find_library(LibtorrentRasterbar_LIBRARY NAMES torrent-rasterbar
             HINTS ${PC_LIBTORRENT_RASTERBAR_LIBDIR} ${PC_LIBTORRENT_RASTERBAR_LIBRARY_DIRS})

set(LibtorrentRasterbar_LIBRARIES ${LibtorrentRasterbar_LIBRARY})
set(LibtorrentRasterbar_INCLUDE_DIRS ${LibtorrentRasterbar_INCLUDE_DIR})

if (NOT Boost_SYSTEM_FOUND OR NOT Boost_THREAD_FOUND OR NOT Boost_DATE_TIME_FOUND OR NOT Boost_CHRONO_FOUND)
    find_package(Boost REQUIRED COMPONENTS system thread date_time chrono)
    set(LibtorrentRasterbar_LIBRARIES ${LibtorrentRasterbar_LIBRARIES} ${Boost_LIBRARIES})
    set(LibtorrentRasterbar_INCLUDE_DIRS ${LibtorrentRasterbar_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})
endif ()

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LibtorrentRasterbar_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LibtorrentRasterbar DEFAULT_MSG
                                  LibtorrentRasterbar_LIBRARY
                                  LibtorrentRasterbar_INCLUDE_DIR
                                  Boost_SYSTEM_FOUND
                                  Boost_THREAD_FOUND
                                  Boost_DATE_TIME_FOUND
                                  Boost_CHRONO_FOUND)

mark_as_advanced(LibtorrentRasterbar_INCLUDE_DIR LibtorrentRasterbar_LIBRARY)