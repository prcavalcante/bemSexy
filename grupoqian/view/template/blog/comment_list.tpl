<?php echo $header; ?>
<div id="content">
   <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
         <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
   </div>

   <div class="container">
      <div id="et-header">
         <span class="em-header"><img src="view/image/blog/blog_manager.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></span>
         
         <ul>
            <li><a href="<?php echo $menu_home_href; ?>"><?php echo $text_menu_home; ?></a></li>
            <li><a href="<?php echo $menu_article_href; ?>"><?php echo $text_menu_article; ?></a></li>
            <li><a href="<?php echo $menu_category_href; ?>"><?php echo $text_menu_category; ?></a></li>
            <li><a href="<?php echo $menu_comment_href; ?>" class="active"><?php echo $text_menu_comment; ?></a></li>
            <?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
               <li><a href="<?php echo $menu_author_href; ?>"><?php echo $text_menu_author; ?></a></li>
            <?php } ?>
            <?php if (isset($haspermission_editSetting)) { ?>
               <li><a href="<?php echo $menu_setting_href; ?>"><?php echo $text_menu_setting; ?></a></li>
            <?php } ?>
            <li><a href="<?php echo $menu_about_href; ?>"><?php echo $text_menu_about; ?></a></li>
         </ul>
      </div>
      <?php if ($error_warning) { ?>
         <div class="warning">
            <?php echo $error_warning; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <?php if ($attention) { ?>
         <div class="attention">            
            <?php echo $attention; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <?php if ($success) { ?>
         <div class="success">
            <?php echo $success; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <div id="et-content">
         <div class="heading">
            <h2><?php echo $heading_list; ?></h2>
            <div class="buttons">
               <?php if (isset($haspermission_editComment)) { ?>
                  <a onclick="$('#form').attr('action', '<?php echo $approve; ?>'); $('#form').submit();" class="button"><?php echo $text_approve; ?></a>
                  <a onclick="$('#form').attr('action', '<?php echo $unapprove; ?>'); $('#form').submit();" class="button"><?php echo $text_unapprove; ?></a>
               <?php } ?>
               <?php if (isset($haspermission_removeComment)) { ?>
                  <a onclick="$('#form').submit();" class="button"><?php echo $button_delete; ?></a>
               <?php } ?>
            </div>
         </div>
         <a href="<?php echo $menu_comment_href; ?>"><?php echo $text_reset; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
         <?php echo $text_filter; ?> <a href="<?php echo $status_all; ?>"><?php echo $text_all; ?></a>, <a href="<?php echo $status_approve; ?>"><?php echo $text_approve; ?></a>, <a href="<?php echo $status_unapprove; ?>"><?php echo $text_unapprove; ?></a>
         <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
            <table class="blogList commentList">
               <thead>
                  <tr>
                     <?php if (isset($haspermission_editComment) || isset($haspermission_removeComment)) { ?>
                        <td width="1" class="center"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
                     <?php } ?>
                     <td class="center" style="width:150px;"><?php echo $text_article; ?></td>
                     <td class="center" style="width:165px;"><?php echo $text_author; ?></td>
                     <td class="center"><?php echo $text_comment; ?></td>
                     <td class="center" style="width:60px;"><?php echo $text_status; ?></td>
                     <?php if (isset($haspermission_editComment) || isset($haspermission_replyComment)) { ?>
                        <td class="center" style="width:75px;"><?php echo $text_action; ?></td>
                     <?php } ?>
                  </tr>
               </thead>
               <tbody>
                  <?php if ($comments) { ?>
                     <?php $class = 'odd'; ?>
                     <?php foreach ($comments as $comment) { ?>
                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                        <tr class="<?php echo $class; if ($comment['badgeClass']) { ?> badge <?php echo strtolower($comment['badgeClass']); } ?>">
                           <?php if (isset($haspermission_editComment) || isset($haspermission_removeComment)) { ?>
                              <td class="center">
                                 <?php if ($comment['selected']) { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $comment['comment_id']; ?>" checked="checked" />
                                 <?php } else { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $comment['comment_id']; ?>" />
                                 <?php } ?>
                              </td>
                           <?php } ?>
                           <td class="left"><a href="<?php echo $comment['art_link']; ?>"><?php echo $comment['article']; ?></a></td>
                           <td class="left">
                              <b><?php echo $comment['name']; ?></b><br/>
                              <div class="blogMeta">
                                 <?php echo $comment['email']; ?><br/>
                                 <?php if ($comment['website']) { echo '<a href="'.$comment['website'].'" target="_blank" title="Open '.$comment['website'].' in new window">' . $comment['website'] . '</a>'; } ?>
                              </div>
                           </td>
                           <td class="left">
                              <div class="blogMeta">
                                 <?php if ($comment['badge']) { echo $comment['badge'] . '<br/>'; } ?>
                                 <?php echo $comment['created']; ?>
                                 <?php if ($comment['in_reply']) { echo ' | In reply to ' . $comment['in_reply']; } ?>
                              </div>
                              <p><?php echo $comment['comment']; ?></p>
                           </td>
                           <td class="center">
                              <?php if ($comment['status']) { echo $text_approve; } else { echo $text_unapprove; }?>
                           </td>
                           <?php if (isset($haspermission_editComment) || isset($haspermission_replyComment)) { ?>
                              <td class="center">
                                 <?php if (isset($haspermission_replyComment)) { ?>
                                    <?php if (!$comment['in_reply']) { echo '<a href="'.$comment['reply'].'" title"">'.$text_reply.'</a>'; } ?>
                                 <?php } ?>
                                 <?php if (!$comment['in_reply'] && (isset($haspermission_editComment) && isset($haspermission_replyComment))) { ?>
                                  - 
                                 <?php } ?>
                                 <?php if (isset($haspermission_editComment)) { ?>
                                    <a href="<?php echo $comment['edit']; ?>" title=""><?php echo $text_edit; ?></a>
                                 <?php } ?>
                              </td>
                           <?php } ?>
                        </tr>
                     <?php } ?>
                  <?php } else { ?>
                     <tr>
                        <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
                     </tr>
                  <?php } ?>
               </tbody>
            </table>
         </form>
         <div class="pagination"><?php echo $pagination; ?></div>
      </div>
      
      <div id="et-footer">
         Blog Manager &copy; <?php if ((date('Y')) == '2011') { echo date('Y'); } else { echo '2011 - '.date('Y');};?> <a href="http://www.echothemes.com" target="_blank">EchoThemes</a>. All right reserved. <br />
         <a href="http://www.opencart.com" target="_blank">OpenCart</a> &copy; 2009-<?php echo date('Y');?> All Rights Reserved. <br /> Version <?php echo sprintf(VERSION); ?>
      </div>
   </div>
</div>

<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<?php echo $footer; ?>