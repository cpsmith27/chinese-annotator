import React, { Component } from "react";
import PropTypes from "prop-types";
import Paragraph from "./Paragraph.js";

class Document extends Component {
  render() {
    console.log("Document received: " + this.props.paragraphs);
    return (
      <div className="ca-document">
        {this.props.paragraphs.map((p, i) => (
          <Paragraph segmentGroups={p} key={i} />
        ))}
      </div>
    );
  }
}

Document.propTypes = {
  paragraphs: PropTypes.arrayOf(PropTypes.array).isRequired
};

export default Document;
