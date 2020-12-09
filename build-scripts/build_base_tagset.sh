#!/bin/bash
set -e

mkdir -p deps tags

# download and extract tagsets
if [ ! -f deps/fresh.7z ]; then
    wget -O deps/fresh.7z "https://www.dropbox.com/s/j6fb3ox6z1xmzzq/fresh_mp_sp_custom_edition_tagset.7z?dl=1"
fi
if [ ! -d deps/fresh ]; then
  # could use -ir@"tag_filter.txt" because we don't need all the tags, but whatever
  7z x deps/fresh.7z -o"deps/fresh"
fi
if [ ! -f deps/refined.7z ]; then
    wget -O deps/refined.7z "https://www.dropbox.com/s/p2d76dsu47axrao/refined_halo1_replacement_tags.7z?dl=1"
fi
if [ ! -d deps/refined_halo1_replacement_tags ]; then
  7z x deps/refined.7z -o"deps"
fi
if [ ! -f deps/editor_tags.7z ]; then
    wget -O deps/editor_tags.7z "https://cdn.discordapp.com/attachments/523620962390769695/654482973390929932/editor_tags.7z"
fi
if [ ! -d deps/editor_tags ]; then
  7z x deps/editor_tags.7z -o"deps/editor_tags"
fi

# overlay tagsets in order
rsync -r "deps/fresh/tags/" tags
rsync -r "deps/editor_tags/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/missing_multipurpose_fixes/dxt1/" tags
# rsync -r "deps/refined_halo1_replacement_tags/fixes/00_active_camo_fix/" tags
# rsync -r "deps/refined_halo1_replacement_tags/fixes/00_contrail_fixes/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/00_incorrect_multipurpose_fixes/" tags
rsync -r "deps/refined_halo1_replacement_tags/enhancements/jesse's_high_resolution_halo_hud/tags/" tags