import React, { useEffect, useRef, useState } from 'react';
import styled, { css } from 'styled-components';
import { colors } from '@styles/variables';
import { flex, skyblueBoxShadow } from '@styles/utils';
import { SubmitButton, CancelButton } from '@shared';
import { Link, useHistory } from 'react-router-dom';
import { uploadService } from '@services';
import { debounce } from '@lib/utils';

const MainContainer = styled.div`
  width: 100%;
  border: 1px solid ${colors.lighterGray};
  border-radius: 5px;
`;

const TitleContainer = styled.div`
  width: calc(100% - 1rem);
  padding: 0.5rem;
`;

const TitleInput = styled.input`
  width: 100%;
  padding: 0.5rem 0 0.5rem 0.5rem;
  border-radius: 5px;
  box-sizing: border-box;
  border: 1px solid ${colors.lighterGray};
  background-color: ${colors.semiWhite};
  outline: 0;
  &:focus {
    ${skyblueBoxShadow}
  }
`;

const TagContainer = styled.div`
  height: 3rem;
  position: relative;
  border-bottom: 1px solid ${colors.lighterGray};
`;

const TagBox = styled.button`
  bottom: -1px;
  left: 0;
  position: absolute;
  margin-left: 0.5rem;
  padding: 0.5rem 1.1rem;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  box-sizing: border-box;
  border: 1px solid ${colors.lighterGray};
  border-bottom-color: white;
  background-color: white;
  font-size: 0.85rem;
  color: ${colors.black6};
  outline: 0;
  z-index: 2;
`;

const ContentContainer = styled.div`
  position: relative;
  padding: 0.5rem;
`;

const TextArea = styled.textarea`
  display: flex;
  flex: 1;
  min-width: 100%;
  max-width: 100%;
  height: 12rem;
  min-height: 13rem;
  max-height: 18rem;
  padding: 0.5rem;
  border: 1px solid ${colors.lighterGray};
  border-bottom: 0;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  box-sizing: border-box;
  background-color: ${colors.semiWhite};
  outline: 0;
  &:focus {
    ${skyblueBoxShadow}
  }
`;

const TextCountBox = styled.div`
  opacity: ${props => (props.visiable ? 1 : 0)};
  transition: 0.4s;
  position: absolute;
  bottom: 2.7rem;
  right: 0.5rem;
  ${flex('flex-end', 'center')};
  font-size: 0.8rem;
  color: ${colors.black7};
  padding: 0.5rem 0.8rem;
`;

const FileLabel = styled.label`
  width: 100%;
  padding: 0.4rem;
  display: block;
  font-size: 0.8rem;
  color: ${colors.black6};
  background-color: ${colors.semiWhite};
  border: 1px solid ${colors.lighterGray};
  border-top: 1px dashed ${colors.lighterGray};
  box-sizing: border-box;
  border-bottom-left-radius: 5px;
  border-bottom-right-radius: 5px;
  cursor: pointer;
`;

const FileSelectInput = styled.input`
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
`;

const ControlBox = styled.div`
  ${flex('space-between', 'center')}
  margin:0.5rem;
`;

export default function CommentInputBox(props) {
  const history = useHistory();

  const { content, setContent, handleSubmit } = props;
  const [debouceClear, setDebouceClear] = useState(undefined);

  const countRef = useRef();
  const contentRef = useRef();

  const [visiable, setVisable] = useState(false);

  useEffect(() => {
    return () => {
      if (debouceClear) {
        clearTimeout(debouceClear);
      }
    };
  });

  const showTextCount = () => {
    setVisable(true);
    countRef.current.textContent = `${contentRef.current.textContent.length} characters`;
    if (debouceClear) {
      clearTimeout(debouceClear);
    }
    setDebouceClear(debounce(() => setVisable(false)));
  };

  const handleContentChange = async ({ target: { value } }) => {
    setContent(value);
    if (debouceClear) {
      clearTimeout(debouceClear);
    }
    setDebouceClear(debounce(showTextCount));
  };

  const handleImageChange = async e => {
    const { files } = e.target;
    const [file] = files;
    e.target.value = null;

    const temp = file.name.split('.');
    temp.pop();
    const fileNameWithoutExt = temp.join('');
    const timestamp = new Date().getTime();

    const prefex = content.slice(-1) !== '\n' && content.length ? '\n' : '';
    const loadingText = `![Uploading ${timestamp}_${file.name}...]()`;
    setContent(content + prefex + loadingText);

    try {
      const formData = new FormData();
      formData.append('imgs', file);

      const {
        data: { fileList },
        status,
      } = await uploadService.addImage(formData);
      if (status === 200) {
        const fileUrl = `![${fileNameWithoutExt}](${fileList[0]})`;
        const rep = contentRef.current.textContent.replace(loadingText, fileUrl);
        setContent(rep);
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
        return;
      }
      console.error(err);
    }
  };

  return (
    <MainContainer>
      <form onSubmit={handleSubmit}>
        <TagContainer>
          <TagBox>Write</TagBox>
        </TagContainer>
        <ContentContainer>
          <TextArea
            name="content"
            placeholder={'Leave a comment'}
            onChange={handleContentChange}
            value={content}
            autoComplete={'off'}
            ref={contentRef}
            required
          ></TextArea>
          <TextCountBox visiable={visiable} ref={countRef}></TextCountBox>
          <FileLabel>
            Attach file by selecting here
            <FileSelectInput name="image" type={'file'} onChange={handleImageChange} />
          </FileLabel>
        </ContentContainer>
        {props.controlBox}
      </form>
    </MainContainer>
  );
}
