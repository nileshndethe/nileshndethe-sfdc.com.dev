/**
 * @File Name          : knowledgeArticleTreePreview.js
 * @Description        :
 * @Author             : Nilesh Dethe
 * @Group              :
 * @Last Modified By   : Nilesh Dethe
 * @Last Modified On   : 6/3/2020, 9:00:44 PM
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    31/5/2020   Nilesh Dethe     Initial Version
 **/
import { LightningElement, wire, track } from "lwc";
import getDataCategoryWithArticles from "@salesforce/apex/KnowledgeArticleTreePreviewController.getDataCategoryWithArticles";

export default class KnowledgeArticleTreePreview extends LightningElement {
  @track articles;

  KnowledgeArticleTreePreview(){
    this.articles  = getDataCategoryWithArticles(); 
    Console.log("articles >> " + this.articles);
  }
  handleOnselect(event) {
     this.articles  = getDataCategoryWithArticles(); 
     Console.log("handleOnselect event handled");
  }

  items = [
    {
      label: "User",
      name: "user",
      disabled: false,
      expanded: true,
      items: [
        {
          label: "Standard User",
          name: "standard_user",
          disabled: false,
          expanded: true,
          items: [],
        },
        {
          label: "Chatter User",
          name: "chatter_user",
          disabled: false,
          expanded: true,
          items: [],
        },
      ],
    },
    {
      label: "Administrator",
      name: "administrator",
      disabled: false,
      expanded: true,
      items: [
        {
          label: "System Administrator",
          name: "system_administrator",
          disabled: false,
          expanded: true,
          items: [],
        },
        {
          label: "Chatter Administrator",
          name: "chatter_administrator",
          disabled: false,
          expanded: true,
          items: [],
        },
      ],
    },
    {
      label: "Community User",
      name: "community_user",
      disabled: false,
      expanded: true,
      items: [
        {
          label: "Community Login User",
          name: "community_login_user",
          disabled: false,
          expanded: true,
          items: [],
        },
        {
          label: "Community Plus Login User",
          name: "community_plus_login_user",
          disabled: false,
          expanded: true,
          items: [],
        },
      ],
    },
  ];
}