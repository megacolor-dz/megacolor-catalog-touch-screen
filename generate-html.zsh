index_anchors_html=""
for d in $(ls images)
do
  # partial of category anchor in main index.html
  cat_name=$(echo $d | sed 's/.*-\(.*\)-.*/\1/')
  cat_img=$(cat images/$d/default.txt | sed 's/\//\\\//g')
  cat_anchor_html=$(cat anchor-fancybox-template.html | sed "s/<%PATH%>/images\/$d\/${cat_img}/" | sed "s/<%DESCRIPTION%>/${cat_name}/" | sed "s/<%TARGET%>/${cat_name}.html/" )
  index_anchors_html=${index_anchors_html}${cat_anchor_html}
  # content of category html page
  name=$(cat images/${d}/name.txt)
  desc=$(cat images/${d}/description.txt)
  cat_index_anchors_html=""
  for img in $(ls images/${d}/*.jpg)
  do
    img=$(echo $img | sed 's/\//\\\//g')
    desc=$(echo $desc | xargs)
    anchor_html=$(cat anchor-fancybox-template.html | sed "s/<%PATH%>/${img}/" | sed "s/<%DESCRIPTION%>/${desc}/")
    cat_index_anchors_html=${cat_index_anchors_html}${anchor_html}
  done
  cat_index_anchors_html=$(echo $cat_index_anchors_html | sed 's/\//\\\//g')
  cat_index_html=$(cat category-template.html | sed "s/<%ANCHORS%>/${cat_index_anchors_html}/")
  echo $cat_index_html > ${cat_name}.html
done
index_anchors_html=$(echo $index_anchors_html | sed 's/\//\\\//g')
index_html=$(cat index-template.html | sed "s/<%ANCHORS%>/${index_anchors_html}/")
echo $index_html > index.html
